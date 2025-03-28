import 'package:dio/dio.dart' as dio;
import 'package:get_storage/get_storage.dart';

class ApiService {
  static const String baseUrl = "http://192.168.1.7:8000/";
  final dio.Dio _dio = dio.Dio(dio.BaseOptions(
    baseUrl: baseUrl,
    contentType: "application/json",
    responseType: dio.ResponseType.json,
  ));

  // Get instance of GetStorage
  final box = GetStorage();

  // Token management
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      dio.Response response = await _dio.post('api/users/login/', data: {
        'username': username,
        'password': password,
      });

      // Store the tokens
      box.write('access_token', response.data['access']);
      box.write('refresh_token', response.data['refresh']);

      return response.data;
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  Future<Map<String, dynamic>> register(
      String username, String password, String email) async {
    try {
      dio.Response response = await _dio.post(
        'api/users/register/', // Your Django endpoint
        data: {
          'username': username,
          'password': password,
          'email': email,
        },
      );

      // If successful, return the response data as Map
      return response.data as Map<String, dynamic>;
    } on dio.DioException catch (e) {
      // Handle Dio-specific errors
      if (e.response != null) {
        // If the API returned an error response (like 400 Bad Request)
        final errorData = e.response!.data as Map<String, dynamic>;
        if (errorData.containsKey('error')) {
          // Throw the specific error message from Django API
          throw Exception(errorData['error']);
        } else {
          throw Exception("Registration failed: ${e.response!.statusMessage}");
        }
      } else {
        // Network error or no response
        throw Exception("Registration failed: Network error - ${e.message}");
      }
    } catch (e) {
      // Handle any other unexpected errors
      throw Exception("Registration failed: $e");
    }
  }

  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    try {
      dio.Response response = await _dio.post('api/token/refresh/', data: {
        'refresh': refreshToken,
      });

      // Store the new tokens
      box.write('access_token', response.data['access']);

      return response.data;
    } catch (e) {
      throw Exception("Token refresh failed: $e");
    }
  }

  Future<Map<String, dynamic>> getStoredTokens() async {
    String? accessToken = box.read('access_token');
    String? refreshToken = box.read('refresh_token');

    if (accessToken == null || refreshToken == null) {
      throw Exception("Tokens are not stored.");
    }

    return {
      'access': accessToken,
      'refresh': refreshToken,
    };
  }
}
