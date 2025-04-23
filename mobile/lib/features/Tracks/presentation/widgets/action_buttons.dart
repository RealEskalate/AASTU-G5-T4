import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onExerciseTap;
  final VoidCallback onProblemsTap;

  const ActionButtons({
    Key? key,
    required this.onExerciseTap,
    required this.onProblemsTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Exercise Button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: onExerciseTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(0, 171, 85, 1),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: Text(
              'Exercise',
              style: GoogleFonts.publicSans(
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Problems Button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: onProblemsTap,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color.fromRGBO(0, 171, 85, 1)),
              foregroundColor: const Color.fromRGBO(0, 171, 85, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Problems',
              style: GoogleFonts.publicSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
