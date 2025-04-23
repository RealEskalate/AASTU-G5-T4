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
              backgroundColor: const Color(0xFFEEEEEE),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xFFEEEEEE)),
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
              valueColor: const AlwaysStoppedAnimation<Color>(
                  Color.fromRGBO(0, 171, 85, 1)),
            ),
          ),

          // Center content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Problems',
                  style: GoogleFonts.publicSans(
                    fontSize: size * 0.073, // Scale font size with circle size
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(
                    height: size * 0.018), // Scale spacing with circle size
                Text(
                  displayMode == ProgressDisplayMode.count
                      ? total.toString()
                      : '${percentValue.toStringAsFixed(1)}%',
                  style: GoogleFonts.publicSans(
                    fontSize: size * 0.145, // Scale font size with circle size
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          // Settings button
          if (onSettingsTap != null)
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: onSettingsTap,
                child: Container(
                  padding: EdgeInsets.all(
                      size * 0.027), // Scale padding with circle size
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(
                        size * 0.018), // Scale radius with circle size
                  ),
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          size * 0.055, // Scale font size with circle size
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
