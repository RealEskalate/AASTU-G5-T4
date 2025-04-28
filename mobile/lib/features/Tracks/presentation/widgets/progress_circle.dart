import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum ProgressDisplayMode {
  count, // Display the total count
  percent // Display the percentage
}

class ProgressCircle extends StatelessWidget {
  final int solved;
  final int total;
  final VoidCallback? onSettingsTap;
  final double size;
  final ProgressDisplayMode displayMode;
  final double strokeWidth;

  const ProgressCircle({
    Key? key,
    required this.solved,
    required this.total,
    this.onSettingsTap,
    this.size = 220.0,
    this.displayMode = ProgressDisplayMode.count,
    this.strokeWidth = 12.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate the progress percentage
    final double progress = total > 0 ? solved / total : 0.0;
    final double percentValue = progress * 100;
    final theme = Theme.of(context);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          // Background circle (light gray)
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: strokeWidth,
              backgroundColor: theme.brightness == Brightness.light
                  ? const Color(0xFFEEEEEE)
                  : const Color(0xFF333333),
              valueColor: AlwaysStoppedAnimation<Color>(
                theme.brightness == Brightness.light
                    ? const Color(0xFFEEEEEE)
                    : const Color(0xFF333333),
              ),
            ),
          ),

          // Progress circle (green)
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: strokeWidth,
              backgroundColor: Colors.transparent,
              valueColor:
                  AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
            ),
          ),

          // Center content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Main value text
                displayMode == ProgressDisplayMode.count
                    ? Text(
                        '$solved/$total',
                        style: GoogleFonts.publicSans(
                          fontSize: size * 0.18,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      )
                    : Text(
                        '${percentValue.toStringAsFixed(0)}%',
                        style: GoogleFonts.publicSans(
                          fontSize: size * 0.18,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),

                // Label text
                Text(
                  'Solved',
                  style: GoogleFonts.publicSans(
                    fontSize: size * 0.08,
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),

          // Optional settings icon
          if (onSettingsTap != null)
            Positioned(
              right: 0,
              child: IconButton(
                icon: Icon(
                  Icons.settings,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                  size: size * 0.12,
                ),
                onPressed: onSettingsTap,
              ),
            ),
        ],
      ),
    );
  }
}
