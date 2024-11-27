import 'package:flutter/material.dart';

class PickerPage extends StatelessWidget {
  const PickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple[100]!,
              Colors.purple[50]!,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Closet Image Display
            Container(
              width: double.infinity,
              height: 300,
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.0,
                  colors: [
                    Color(0xFFFFFFFF), // FFFFFF - 0%
                    Color(0xFFE9DFF1), // E9DFF1 - 38%
                    Color(0xFFD4BFE4), // D4BFE4 - 100%
                  ],
                  stops: [0.0, 0.38, 1.0],
                ),
                image: DecorationImage(
                  image: AssetImage(
                    'autopick/app/images/high-quality-modular-wardrobes-forster-great-lakes-removebg-preview.png',
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.white54, // Adjust transparency
                    BlendMode.dstATop,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 70),
            // Arrow Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Left Arrow Button with Background Color
                Container(
                  decoration: BoxDecoration(
                    color: Colors.purple[300],
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_left, size: 50, color: Colors.white),
                    onPressed: () {
                      // Logic to rotate or pick previous item
                    },
                  ),
                ),
                // Right Arrow Button with Background Color
                Container(
                  decoration: BoxDecoration(
                    color: Colors.purple[300],
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_right, size: 50, color: Colors.white),
                    onPressed: () {
                      // Logic to rotate or pick next item
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 150),
            // Get Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.red[300],
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              onPressed: () {
                // Add Onclick Navigation
              },
              child: Text(
                'PICK',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Colors.red[300],
                ),
              ),
            ),
            const SizedBox(height: 105),
          ],
        ),
      ),
    );
  }
}
