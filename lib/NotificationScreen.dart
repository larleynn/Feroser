import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final bool showBackButton;  // Add a boolean property for showing back button
  final VoidCallback? onBackButtonPressed;  // Add a callback for custom back button behavior

  const NotificationScreen({
    super.key,
    this.showBackButton = true,  // Default value for showing back button
    this.onBackButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(fontSize: 18, color: Colors.redAccent),
        ),
        leading: showBackButton
            ? IconButton(
          onPressed: onBackButtonPressed ?? () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.redAccent,
          ),
        )
            : null,
        backgroundColor: Colors.transparent,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_active,
              size: 50,
              color: Colors.redAccent,
            ),
            SizedBox(height: 20),
            Text(
              'You have no new notifications.',
              style: TextStyle(fontSize: 18, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
