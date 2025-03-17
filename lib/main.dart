import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relief/controllers/LocationController.dart';
import 'package:relief/controllers/settings/emergency_contacts_controller.dart';
import 'package:relief/controllers/theme/AppThemes.dart';
import 'package:relief/controllers/theme/ThemeController.dart';
import 'package:relief/controllers/weatherController.dart';
import 'package:relief/screens/MainPage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:relief/screens/OnBoardingScreen.dart';

void main() async {
  await GetStorage.init();

  // Load SOS Message Settings
  final EmergencySettingsController emergencySettingsController =
      Get.put(EmergencySettingsController());
  await emergencySettingsController.loadData();

  // get Location
  final LocationController locationController = Get.put(LocationController());
  locationController.loadLocation();

  // fetch weather
  final WeatherController weathercontroller = Get.put(WeatherController());
  weathercontroller.fetchWeather(
      locationController.latitude.value, locationController.longitude.value);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: themeController.themeMode.value,
        home: OnboardingScreen(),
      );
    });
  }
}
