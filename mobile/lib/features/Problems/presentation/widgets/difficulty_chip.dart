import 'package:flutter/material.dart';
import 'package:mobile/features/Problems/domain/entities/problem_entity.dart';

class DifficultyChip extends StatelessWidget {
  final ProblemDifficultyLevel difficulty;

  const DifficultyChip({required this.difficulty, super.key});

  Color _getBackgroundColor(String difficultyString) {
    // Corresponds to _getFilterColor
    switch (difficultyString) {
      case "Easy":
        return Colors.green[100]!;
      case "Medium":
        // Using orange[100] for consistency, yellow[100] is very light
        return Colors.orange[100]!;
      case "Hard":
        return Colors.red[100]!;
      default: // For "N/A" or unknown
        return Colors.grey[200]!;
    }
  }

  Color _getTextColor(String difficultyString) {
    // Corresponds to _getTextColor
    switch (difficultyString) {
      case "Easy":
        return Colors.green[800]!;
      case "Medium":
        // Using orange[800] for consistency
        return Colors.orange[800]!;
      case "Hard":
        return Colors.red[800]!;
      default: // For "N/A" or unknown
        return Colors.grey[800]!;
    }
  }

  // Helper to convert enum to the string expected by color functions
  String _getDifficultyString(ProblemDifficultyLevel level) {
    switch (level) {
      case ProblemDifficultyLevel.easy:
        return 'Easy';
      case ProblemDifficultyLevel.medium:
        return 'Medium';
      case ProblemDifficultyLevel.hard:
        return 'Hard';
      case ProblemDifficultyLevel.unknown:
      default:
        return 'N/A'; // Map unknown to the default case
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the string representation first
    final String difficultyString = _getDifficultyString(difficulty);

    // Then get the colors based on the string
    final Color backgroundColor = _getBackgroundColor(difficultyString);
    final Color textColor = _getTextColor(difficultyString);

    // Use a Container for custom styling to match the desired look
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 3.0,
        ), // Adjust padding
        decoration: BoxDecoration(
          color: backgroundColor, // Use the calculated background color
          borderRadius: BorderRadius.circular(4.0), // Slightly rounded corners
        ),
        child: Text(
          difficultyString, // Display the string representation
          style: TextStyle(
            color: textColor, // Use the calculated text color
            fontWeight: FontWeight.w500, // Slightly bold
            fontSize: 11, // Smaller font size
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
