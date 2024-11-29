import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PickerPage extends StatelessWidget {
  const PickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    // List of image paths for the carousel
    final List<String> imagePaths = [
      'autopick/app/images/casual_clothes.jpg',
      'autopick/app/images/formal_clothes.jpg',
      'autopick/app/images/sleeping_clothes.jpg',
      'autopick/app/images/uniform.jpg',
    ];

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
            // Closet Image Carousel
            CarouselSlider(
              options: CarouselOptions(
                height: 300,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                autoPlay: true,
              ),
              items: imagePaths.map((path) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    gradient: const RadialGradient(
                      center: Alignment.topLeft,
                      radius: 1.0,
                      colors: [
                        Color(0xFFFFFFFF),
                        Color(0xFFE9DFF1),
                        Color(0xFFD4BFE4),
                      ],
                      stops: [0.0, 0.38, 1.0],
                    ),
                    image: DecorationImage(
                      image: AssetImage(path),
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(
                        Colors.white54,
                        BlendMode.dstATop,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 70),
            // Arrow Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Left Arrow Button
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
                // Right Arrow Button
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
            const SizedBox(height: 85),
          ],
        ),
      ),
    );
  }
}
