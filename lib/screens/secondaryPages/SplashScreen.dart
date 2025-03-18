import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:relief/controllers/AuthController.dart';
import 'package:relief/controllers/OnboardingController.dart';
import 'package:relief/screens/MainPage.dart';
import 'package:relief/screens/auth/LoginScreen.dart';
import 'package:relief/screens/secondaryPages/OnBoardingScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

final AuthController authController = Get.put(AuthController());

class _SplashScreenState extends State<SplashScreen> {
  // Duration for splash screen
  @override
  void initState() {
    super.initState();
    _startSplashScreen();
  }

  // Function to delay the splash screen and navigate to the main screen
  void _startSplashScreen() async {
    // Wait for 3 seconds to show the splash screen
    await Future.delayed(Duration(seconds: 3));

    // Check if the user is authenticated
    bool isAuthenticated = await _checkAuthentication();

    if (isAuthenticated) {
      // If authenticated, check if it's the user's first time
      OnboardingController onboardingController =
          Get.put(OnboardingController());

      if (onboardingController.isFirstTimeUser.value) {
        // If it's the user's first time, navigate to Onboarding Screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
        );
      } else {
        // If not first time, navigate to the home screen or main page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      }
    } else {
      // If not authenticated, navigate to Login Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Loginscreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add your logo here (optional)
            // Image.asset('assets/splash_logo.png'),
            SizedBox(height: 20),
            CircularProgressIndicator(), // Optional loading indicator
          ],
        ),
      ),
    );
  }

  Future<bool> _checkAuthentication() async {
    // Retrieve the stored access token from GetStorage
    final box = GetStorage();
    String? accessToken = box.read('access_token');

    if (accessToken != null && accessToken.isNotEmpty) {
      // If the access token exists, refresh the token (optional)
      await authController.refreshTokenIfNeeded();
      if (authController.isLoggedIn.value) {
        return true; // User is authenticated
      } else {
        return false;
      }
    } else {
      return false; // User is not authenticated
    }
  }
}
