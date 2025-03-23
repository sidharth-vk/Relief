import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relief/screens/MainPage.dart';
import 'package:relief/screens/auth/LoginScreen.dart';
import 'package:relief/services/authservice.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  var accessToken = ''.obs;
  var refreshToken = ''.obs;
  var userName = " ".obs;

  @override
  void onInit() {
    super.onInit();
    profile();
  }

  ApiService _apiService = ApiService();
  final box = GetStorage();

  Future<void> profile() async {
    var username = box.read('username');
    userName.value = username;
  }

  // Handle Login
  Future<void> login(String username, String password) async {
    try {
      isLoading(true);
      var result = await _apiService.login(username, password);
      accessToken.value = result['access'];
      refreshToken.value = result['refresh'];
      userName.value = username;
      box.write('username', username);

      isLoggedIn.value = true;

      Get.offAll(MainPage());
    } catch (e) {
      Get.snackbar("Error", "Login failed: $e");
    } finally {
      isLoading(false);
    }
  }

  // Handle Registration
  Future<void> register(String username, String password, String email) async {
    try {
      isLoading(true);
      var result = await _apiService.register(username, password, email);
      login(username, password);
      Get.snackbar("Success", "Registration successful",
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Registration failed: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }

  // Refresh the Token
  Future<void> refreshTokenIfNeeded() async {
    try {
      Map<String, dynamic> storedTokens = await _apiService.getStoredTokens();
      accessToken.value = storedTokens['access'];
      refreshToken.value = storedTokens['refresh'];

      // Refresh token if necessary
      var newTokens = await _apiService.refreshToken(refreshToken.value);
      accessToken.value = newTokens['access'];
      isLoggedIn.value = true;
    } catch (e) {
      isLoggedIn.value = false;
      logout();
    }
  }

  void logout() async {
    try {
      isLoading(true);
      box.remove('access_token');
      box.remove('refresh_token');

      isLoggedIn.value = false;

      Get.offAll(() => Loginscreen());
    } catch (e) {
      print("Logout failed: $e");
    } finally {
      isLoading(false);
    }
  }
}
