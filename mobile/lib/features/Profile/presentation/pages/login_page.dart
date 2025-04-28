import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Implement the UI based on the provided image
    // Approximate colors from the image
    const primaryColor = Color(0xFF1DB954); // Green color
    const backgroundColor = Color(0xFFFAF9F6); // Off-white background
    const textColor = Colors.black87;
    const secondaryTextColor = Colors.black54;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Logo and Login Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Placeholder for HUB Logo
                  const Text(
                    'HUB', // Replace with actual logo widget if available
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: primaryColor, // Or use logo asset
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement login navigation/action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Login'),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Navigation Links
              Row(
                mainAxisAlignment: MainAxisAlignment.start, // Align to start
                children: [
                  _buildNavLink('Home', isActive: true, color: primaryColor),
                  const SizedBox(width: 20),
                  _buildNavLink('Docs', color: secondaryTextColor),
                  const SizedBox(width: 20),
                  _buildNavLink('Blog', color: secondaryTextColor),
                  const SizedBox(width: 20),
                  _buildNavLink('About A2SV', color: secondaryTextColor),
                ],
              ),
              const SizedBox(height: 60), // Adjust spacing as needed

              // Main Content Text
              Text(
                'No more jumbling in sheets. focus on your code,',
                style: TextStyle(
                  fontSize: 36, // Adjust size
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  height: 1.3,
                ),
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    // Default style for the span
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    height: 1.3,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: "we'll keep track of "),
                    TextSpan(
                      text: 'everything.',
                      style: TextStyle(
                        color: primaryColor,
                        shadows: [
                          // Add a glow effect
                          Shadow(
                            blurRadius: 15.0,
                            color: primaryColor.withOpacity(0.7),
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30), // Adjust spacing

              // Sub Text
              Text(
                'Empower Collaboration and Efficiency: Experience Seamless Educational Endeavors with the A2SV Hub, Your Centralized Solution for Streamlining Organization, Collaboration, and Knowledge Sharing.',
                style: TextStyle(
                  fontSize: 16,
                  color: secondaryTextColor,
                  height: 1.5,
                ),
              ),

              // Add Spacer if content should be pushed up
              // const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavLink(String title, {bool isActive = false, Color? color}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () {
            // TODO: Implement navigation for this link
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero, // Remove default padding
            minimumSize: Size(50, 30), // Adjust size if needed
            alignment: Alignment.center,
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color:
                  isActive ? color : Colors.grey[600], // Use grey for inactive
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        if (isActive)
          Container(
            height: 2,
            width: 40, // Width of the underline
            color: color,
          ),
      ],
    );
  }
}
