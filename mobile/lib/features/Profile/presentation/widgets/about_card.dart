import 'package:flutter/material.dart';

class AboutCard extends StatelessWidget {
  final String name;
  final String tagline;
  final String location;
  final String email;
  final String programmingLanguage;
  final String currentPosition;
  final String education;

  const AboutCard({
    Key? key,
    required this.name,
    required this.tagline,
    required this.location,
    required this.email,
    required this.programmingLanguage,
    required this.currentPosition,
    required this.education,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // About section header
              const Text(
                'About',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              // Tagline
              Text(
                tagline,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              // Location
              _buildInfoRow(
                Icons.location_on,
                location,
                Colors.black87,
              ),
              const SizedBox(height: 12),

              // Email
              _buildInfoRow(
                Icons.email,
                email,
                const Color(0xFF663300), // Brown color for email
              ),
              const SizedBox(height: 12),

              // Programming language
              _buildInfoRow(
                Icons.code,
                programmingLanguage,
                Colors.black87,
              ),
              const SizedBox(height: 12),

              // Current position
              _buildInfoRow(
                Icons.people,
                currentPosition,
                Colors.black87,
              ),
              const SizedBox(height: 12),

              // Education
              _buildInfoRow(
                Icons.school,
                education,
                Colors.black87,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color textColor,
      {int maxLines = 1}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.black54,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
              color: textColor,
              height: 1.3,
            ),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class AboutCardExample extends StatelessWidget {
  const AboutCardExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AboutCard(
      name: 'Natnael Wondwoesn',
      tagline: 'Very Inspired to be Great',
      location: 'Ethiopia',
      email: 'natnael.wondwoesn@a2sv.org',
      programmingLanguage: 'Python',
      currentPosition: 'Student at AASTU Group 57',
      education:
          'Studied at Addis Ababa Science and Technology University (AASTU)',
    );
  }
}
