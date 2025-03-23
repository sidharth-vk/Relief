import 'package:dio/dio.dart' as dio;
import 'dart:io';

class RequestRescueService {
  static const String baseUrl = "http://192.168.1.7:8000/";
  final dio.Dio _dio = dio.Dio(dio.BaseOptions(baseUrl: baseUrl));

  Future<Map<String, dynamic>?> uploadData(
    String name,
    String explainSituation,
    String additionalInformation,
    String address,
    String state,
    String city,
    String phoneNumber,
    List<File> mediaFiles,
  ) async {
    try {
      // Add logging for debugging
      _dio.interceptors
          .add(dio.LogInterceptor(requestBody: true, responseBody: true));

      dio.FormData formData = dio.FormData();

      // Add text fields
      formData.fields.addAll([
        MapEntry("name", name),
        MapEntry("explanation", explainSituation),
        MapEntry("additional_information", additionalInformation),
        MapEntry("address", address),
        MapEntry("state", state),
        MapEntry("city", city),
        MapEntry("phone_number", phoneNumber),
      ]);

      // Add all media files under the "media" key
      if (mediaFiles.isNotEmpty) {
        for (var file in mediaFiles) {
          formData.files.add(MapEntry(
            "media", // Use the same key for all files
            await dio.MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            ),
          ));
        }
      }

      dio.Response response = await _dio.post(
        "api/immediate_relief/rescue-instances/",
        data: formData,
      );

      print("Response: ${response.data}");
      return response.data;
    } on dio.DioException catch (e) {
      print(
          "Dio Error: ${e.response?.statusCode} - ${e.response?.statusMessage}");
      print("Response Data: ${e.response?.data}");
      return {
        "error": true,
        "statusCode": e.response?.statusCode,
        "message": e.response?.statusMessage,
        "data": e.response?.data,
      };
    } catch (e) {
      print("Unexpected Error: $e");
      return {"error": true, "message": "An unexpected error occurred"};
    }
  }
}
