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
            radius: 1.2, // Adjusted radius for better coverage
            colors: [
              Color(0xFFFFFFFF), // FFFFFF - 0%
              Color(0xFFE9DFF1), // E9DFF1 - 38%
              Color(0xFFD4BFE4), // D4BFE4 - 100%
            ],
            stops: [0.0, 0.38, 1.0],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 165, // Adjust the vertical positioning as needed
              right: 10,  // Ensures the image sticks to the very left edge
              child: Opacity(
                opacity: 0.7, // Adjust the transparency level (70% visible)
                child: Container(
                  width: 550,
                  height: 550,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('autopick/app/images/model.png'),
                      fit: BoxFit.cover,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40, // Adjust the vertical positioning as needed
              left: 250,  // Ensures the image sticks to the very left edge
              child: Opacity(
                opacity: 0.7, // Adjust the transparency level (70% visible)
                child: Container(
                  width: 150,
                  height: 300,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('autopick/app/images/lheyyy.png'),
                      fit: BoxFit.cover,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 120),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 70.0),
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
                      color: Colors.white,
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
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.red[300],
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WelcomePage()),
                    );
                  },
                  child: const Text(
                    'GET STARTED',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                const SizedBox(height: 120),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
