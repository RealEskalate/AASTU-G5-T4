import 'package:flutter/material.dart';

class CircularProfileImage extends StatelessWidget {
  final String? imageUrl;
  final double radius;

  const CircularProfileImage({
    super.key,
    this.imageUrl,
    this.radius = 20.0, // Default radius, similar to the image
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey[300], // Placeholder background
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
      // Optional: Add an icon if imageUrl is null
      child: imageUrl == null
          ? Icon(
              Icons.person,
              size: radius, // Adjust icon size based on radius
              color: Colors.white,
            )
          : null,
    );
  }
}
