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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50), // Adjust this value to control the spacing
              // Closet Image Carousel
              CarouselSlider(
                options: CarouselOptions(
                  height: 300, // Fixed height for uniform sizing
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                ),
                items: imagePaths.map((path) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 250, // Fixed width to maintain uniformity
                      height: 300, // Matches the carousel's height
                      decoration: BoxDecoration(
                        color: Colors.white, // Optional background for clarity
                      ),
                      child: FittedBox(
                        fit: BoxFit.contain, // Ensures the image fits within the box
                        child: Image.asset(
                          path,
                          width: 250, // Same fixed width
                          height: 300, // Matches the fixed height
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
      ),
    );
  }
}
