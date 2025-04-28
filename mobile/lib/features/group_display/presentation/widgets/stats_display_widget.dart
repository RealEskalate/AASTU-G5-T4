import 'package:flutter/material.dart';

class StatsDisplayWidget extends StatelessWidget {
  // TODO: Replace hardcoded values with parameters
  final String timeSpent = "256,744";
  final String solvedProblems = "770";
  final String avgRating = "1,282";

  const StatsDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const dividerColor = Color(0xFF1DB954); // Green color from image
    const labelColor = Colors.grey;
    const valueColor = Colors.black87;
    const double dividerHeight = 40.0; // Approximate height
    const double dividerWidth = 4.0;

    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceAround, // Distribute items evenly
      children: [
        _buildStatItem(
          label: "Time Spent",
          value: timeSpent,
          dividerColor: dividerColor,
          labelColor: labelColor,
          valueColor: valueColor,
          dividerHeight: dividerHeight,
          dividerWidth: dividerWidth,
        ),
        _buildStatItem(
          label: "Solved Problems",
          value: solvedProblems,
          dividerColor: dividerColor,
          labelColor: labelColor,
          valueColor: valueColor,
          dividerHeight: dividerHeight,
          dividerWidth: dividerWidth,
        ),
        _buildStatItem(
          label: "Avg. Rating",
          value: avgRating,
          dividerColor: dividerColor,
          labelColor: labelColor,
          valueColor: valueColor,
          dividerHeight: dividerHeight,
          dividerWidth: dividerWidth,
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required Color dividerColor,
    required Color labelColor,
    required Color valueColor,
    required double dividerHeight,
    required double dividerWidth,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: dividerHeight,
          width: dividerWidth,
          color: dividerColor,
        ),
        const SizedBox(width: 12), // Space between divider and text
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Take minimum vertical space
          children: [
            Text(
              label,
              style: TextStyle(
                color: labelColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4), // Space between label and value
            Text(
              value,
              style: TextStyle(
                color: valueColor,
                fontSize: 20, // Larger font size for value
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
