import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:relief/controllers/Weather_and_Location/LocationController.dart';
import 'package:relief/controllers/settings/emergency_contacts_controller.dart';
import 'package:relief/controllers/theme/AppThemes.dart';
import 'package:relief/controllers/theme/ThemeController.dart';
import 'package:relief/controllers/Weather_and_Location/weatherController.dart';
import 'package:relief/screens/MainPage.dart';
import 'package:relief/screens/secondaryPages/OnBoardingScreen.dart';
import 'package:relief/screens/secondaryPages/SplashScreen.dart';

// Initialize the local notifications plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
  print('Message data: ${message.data}');
  if (message.notification != null) {
    print(
        'Notification: ${message.notification?.title}, ${message.notification?.body}');
    // Optionally show a local notification for background messages if needed
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize GetStorage
  await GetStorage.init();

  // Put controllers in GetX dependency injection
  Get.put(EmergencySettingsController());
  Get.put(LocationController());
  Get.put(WeatherController());
  Get.put(ThemeController());

  // Load SOS Message Settings
  final emergencySettingsController = Get.find<EmergencySettingsController>();
  await emergencySettingsController.loadData();

  // Update Location
  final locationController = Get.find<LocationController>();
  await locationController.updateLocation();

  // Fetch Weather
  final weatherController = Get.find<WeatherController>();
  weatherController.fetchWeather(
    locationController.latitude.value,
    locationController.longitude.value,
  );

  // Set up Firebase Messaging and local notifications
  await setupFirebaseMessaging();

  runApp(const MyApp());
}

Future<void> setupFirebaseMessaging() async {
  final messaging = FirebaseMessaging.instance;

  // Request permission for iOS
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');

  // Initialize local notifications
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher'); // Use your app icon
  const DarwinInitializationSettings iosSettings =
      DarwinInitializationSettings();
  const InitializationSettings initializationSettings =
      InitializationSettings(android: androidSettings, iOS: iosSettings);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Create an Android Notification Channel (required for Android 8.0+)
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // Channel ID
    'High Importance Notifications', // Channel name
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // Set up background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Handle foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    if (message.notification != null) {
      print(
          'Notification: ${message.notification?.title}, ${message.notification?.body}');

      // Show the notification in the system tray
      await flutterLocalNotificationsPlugin.show(
        message.hashCode, // Unique ID for the notification
        message.notification?.title ?? 'No Title',
        message.notification?.body ?? 'No Body',
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            importance: Importance.max,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: message.data.toString(), // Optional: Pass data as payload
      );
    }
  });

  // await flutterLocalNotificationsPlugin.initialize(
  //   initializationSettings,
  //   onDidReceiveNotificationResponse: (NotificationResponse response) {
  //     // Handle tap on notification (foreground)
  //     final String? payload = response.payload;
  //     print('Notification tapped with payload: $payload');
  //     Get.to(() => MainPage()); // Navigate to MainPage (or custom page)
  //   },
  // );

  // Handle when app is opened from a notification
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Message opened app: ${message.messageId}');
    print('Message data: ${message.data}');
  });

  // Get and print the FCM token
  String? token = await messaging.getToken();
  print('FCM Token: $token');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: themeController.themeMode.value,
        home: SplashScreen(), // Switch to SplashScreen or MainPage as needed
      );
    });
  }
}
