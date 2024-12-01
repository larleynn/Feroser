import 'dart:async';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PickerPage extends StatefulWidget {
  const PickerPage({super.key});

  @override
  State<PickerPage> createState() => _PickerPageState();
}

class _PickerPageState extends State<PickerPage> {
  // List of image paths for the carousel
  final List<String> imagePaths = [
    'autopick/app/images/casual_clothes.png',
    'autopick/app/images/formal_clothes.png',
    'autopick/app/images/sleeping_clothes.png',
    'autopick/app/images/uniform.png',
  ];

  // Variable to control the currently displayed image
  String? _selectedImage;
  Timer? _timer;

  // Function to handle button press logic
  void _showImageForDuration(String imagePath) {
    setState(() {
      _selectedImage = imagePath; // Set the selected image
    });

    // Cancel any existing timer
    _timer?.cancel();

    // Set a timer to revert back to carousel after 3 seconds
    _timer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _selectedImage = null; // Reset to carousel mode
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              // Display either the selected image or the carousel
              if (_selectedImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 250,
                    height: 300,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4BFE4),
                    ),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Image.asset(
                        _selectedImage!,
                        width: 250,
                        height: 300,
                      ),
                    ),
                  ),
                )
              else
                CarouselSlider(
                  options: CarouselOptions(
                    height: 300,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                  ),
                  items: imagePaths.map((path) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 250,
                        height: 300,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4BFE4),
                        ),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Image.asset(
                            path,
                            width: 250,
                            height: 300,
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
              const SizedBox(height: 50),
              // Additional Buttons Below Arrows
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xFFFF6C4B),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: () => _showImageForDuration('autopick/app/images/uniform.png'),
                          child: const Text(
                            'Uniform',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xFFFF6C4B),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: () => _showImageForDuration('autopick/app/images/casual_clothes.png'),
                          child: const Text(
                            'Casual Clothes',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xFFFF6C4B),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: () => _showImageForDuration('autopick/app/images/sleeping_clothes.png'),
                          child: const Text(
                            'Sleeping Clothes',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xFFFF6C4B),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: () => _showImageForDuration('autopick/app/images/formal_clothes.png'),
                          child: const Text(
                            'Formal Clothes',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 80),
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
                  'GET',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Colors.red[300],
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
