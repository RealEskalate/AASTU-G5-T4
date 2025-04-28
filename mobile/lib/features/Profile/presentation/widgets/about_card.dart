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
    final theme = Theme.of(context);

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        color: theme.colorScheme.surface,
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
              Text(
                'About',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),

              // Tagline
              Text(
                tagline,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),

              // Location
              _buildInfoRow(
                context,
                Icons.location_on,
                location,
              ),
              const SizedBox(height: 12),

              // Email
              _buildInfoRow(
                context,
                Icons.email,
                email,
                textColor: theme.colorScheme.primary,
              ),
              const SizedBox(height: 12),

              // Programming language
              _buildInfoRow(
                context,
                Icons.code,
                programmingLanguage,
              ),
              const SizedBox(height: 12),

              // Current position
              _buildInfoRow(
                context,
                Icons.people,
                currentPosition,
              ),
              const SizedBox(height: 12),

              // Education
              _buildInfoRow(
                context,
                Icons.school,
                education,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text,
      {Color? textColor, int maxLines = 1}) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: theme.colorScheme.onSurface.withOpacity(0.6),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
              color: textColor ?? theme.colorScheme.onSurface,
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
