import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'LandingPage.dart';

// Declare the global instance for notifications
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// Global key for navigation
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyC_VIwxmNY7N8XgkSDcP27FLu4vDFaoMYk",
      authDomain: "autopick-51616.firebaseapp.com",
      projectId: "autopick-51616",
      storageBucket: "autopick-51616.appspot.com",
      messagingSenderId: "179715410158",
      appId: "1:179715410158:android:7a5b8f6f7c23e96a920bff",
    ),
  );

  // Initialize local notifications
  await _initializeLocalNotifications();

  // Handle background messages
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize Firebase Cloud Messaging
  await _initializeFCM();

  runApp(const MyApp());
}

// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

// Initialize local notifications and create notification channel
Future<void> _initializeLocalNotifications() async {
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'default_channel', // Channel ID
    'Default Notifications', // Channel name
    description: 'This channel is used for important notifications.',
    importance: Importance.high, // High importance for notifications
  );

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('app_icon');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

// Initialize FCM and handle token
Future<void> _initializeFCM() async {
  try {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request permissions (iOS only, no-op on Android)
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Notification permissions granted');

      // Retrieve the FCM token
      String? token = await messaging.getToken();
      if (token != null) {
        print('FCM Token: $token');
        // Optionally, send this token to your backend if needed
      }

      // Handle incoming messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Message received: ${message.notification?.title}, ${message.notification?.body}');

        // Show notification using flutter_local_notifications
        flutterLocalNotificationsPlugin.show(
          0,
          message.notification?.title,
          message.notification?.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'default_channel', // Channel ID
              'Default Notifications', // Channel name
              channelDescription: 'This channel is used for default notifications.',
              importance: Importance.high,
              priority: Priority.high,
              icon: 'app_icon',
            ),
          ),
          payload: message.notification?.body, // Pass the message body as payload
        );
      });
    } else {
      print('Notification permissions denied');
    }
  } catch (e) {
    print('Error initializing FCM: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FCM Demo',
      navigatorKey: navigatorKey, // Set the navigator key
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const LandingPage(),
    );
  }
}
