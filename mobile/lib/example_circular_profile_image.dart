import 'package:flutter/material.dart';
// Make sure the path to the widget is correct based on your project structure
import 'features/group_display/presentation/widgets/circular_profile_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CircularProfileImage Example'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Example 1: With an image URL
                const CircularProfileImage(
                  // Replace with a valid image URL for testing
                  imageUrl: 'https://via.placeholder.com/150',
                  radius: 30.0,
                ),

                // Example 2: Without an image URL (shows default icon)
                const CircularProfileImage(
                  radius: 25.0, // Different radius
                ),

                // Example 3: Default radius
                const CircularProfileImage(
                  imageUrl: 'https://via.placeholder.com/100',
                ),

                // Example 4: Smaller radius
                const CircularProfileImage(
                  radius: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
