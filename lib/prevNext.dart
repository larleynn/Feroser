import 'dart:async';
import 'package:feroser/WelcomePage.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'PickerPage.dart';
import 'header.dart';

class prevNext extends StatefulWidget {
  const prevNext({super.key});

  @override
  State<prevNext> createState() => _PickerPageState();
}

class _PickerPageState extends State<prevNext> {
  // List of image paths for the carousel
  final List<String> imagePaths = [
    'autopick/app/images/casual_clothes.png',
    'autopick/app/images/formal_clothes.png',
    'autopick/app/images/sleeping_clothes.png',
    'autopick/app/images/uniform.png',
  ];

  int _currentIndex = 0;

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

  void _nextImage() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % imagePaths.length; // Go to next image
      _selectedImage = imagePaths[_currentIndex];
    });
  }

  void _previousImage() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + imagePaths.length) % imagePaths.length; // Go to previous image
      _selectedImage = imagePaths[_currentIndex];
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
      extendBodyBehindAppBar: true,
      appBar: const SharedHeader(
        title: '',
        showNotificationIcon: true,
      ),
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
              const SizedBox(height: 80),
              // Display either the selected image or the carousel
              if (_selectedImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 250,
                    height: 300,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD4BFE4),
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
                        decoration: const BoxDecoration(
                          color: Color(0xFFD4BFE4),
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
                      onPressed: _previousImage, // Call _previousImage on press
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.purple[300],
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_right, size: 50, color: Colors.white),
                      onPressed: _nextImage, // Call _nextImage on press
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
              // Get and Done Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.redAccent,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),

                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ProcessingScreen()),
                      );
                    },
                    child: const Text(
                      'GET',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.redAccent,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: const Text(
                      'DONE',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}