import 'package:flutter/material.dart';
import 'NotificationScreen.dart';

class SharedHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title; // Optional title for the AppBar
  final bool showNotificationIcon; // Toggle notification icon
  final bool showBackButton; // Toggle back button
  final VoidCallback? onBackButtonPressed; // Custom back button action

  const SharedHeader({
    super.key,
    this.title = '',
    this.showNotificationIcon = true,
    this.showBackButton = true,
    this.onBackButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent, // Makes the AppBar transparent
      elevation: 0, // Removes shadow
      centerTitle: false,
      leading: showBackButton
          ? IconButton(
        onPressed: onBackButtonPressed ?? () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.redAccent,
        ),
      )
          : null,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.redAccent,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: showNotificationIcon
          ? [
        Padding(
          padding: const EdgeInsets.only(right: 14.0, top: 8.0), // Adjusts the placement
          child: IconButton(
            onPressed: () {
              // Navigate to the Notification Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.notifications,
              color: Colors.redAccent,
            ),
          ),
        ),
      ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
