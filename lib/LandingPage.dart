import 'package:flutter/material.dart';

import 'WelcomePage.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 120), // Adjusted spacing from the top
            const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 70.0), // Adjust right margin
                child: Text(
                  'rotate me,\nget me,\npick me!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFE03F1B),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            const Spacer(),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [
                  Color(0xFFEEC7BE), // 0%
                  Color(0xFFFF6C4B), // 35%
                  Color(0xFFE03F1B), // 100%
                ],
                stops: [0.0, 0.35, 1.0],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                'AutoPick!',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Acts as a placeholder for the gradient
                  shadows: [
                    Shadow(
                      offset: const Offset(0, 5),
                      blurRadius: 5,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10), // Adjusted spacing between the text and button
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomePage()),
                );
              },
              child: Text(
                'GET STARTED',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.red[300],
                ),
              ),
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}
