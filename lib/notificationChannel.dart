import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> notificationChannel() async {
  // Initialize FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // Initialize settings for Android
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('app_icon');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  // Initialize the plugin
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Define the notification channel
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'default_channel', // Channel ID
    'Default Notifications', // Channel Name
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  // Create the notification channel
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  print("Notification channel created.");
}