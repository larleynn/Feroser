import 'package:flutter/material.dart';

class SharedHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title; // Optional title for the AppBar
  final bool showBackButton; // Toggle back button
  final VoidCallback? onBackButtonPressed; // Custom back button action

  const SharedHeader({
    super.key,
    this.title = '',
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
