import 'package:flutter/material.dart';

// Assuming _showFilterDialog is defined in the parent widget (ProblemsPage)
// and passed down or accessed via context/callback if needed.
// For now, the onPressed will just print. We'll connect it later in ProblemsPage.
typedef FilterCallback = void Function();

class ProblemToolbar extends StatelessWidget {
  final FilterCallback? onFiltersPressed; // Callback to show filter dialog

  const ProblemToolbar({this.onFiltersPressed, super.key});

  @override
  Widget build(BuildContext context) {
    final Color iconColor = const Color.fromARGB(255, 87, 86, 86)!;
    final Color textColor = Colors.grey[850]!;
    const double iconSize = 18.0;
    const double fontSize = 14.0;

    // Style for the buttons to make them look consistent
    final ButtonStyle buttonStyle = TextButton.styleFrom(
      foregroundColor: textColor, // Text and icon color
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: fontSize,
      ),
    );

    return Container(
      // Add a light background and padding like the reference image
      color: Colors.grey[100], // Very light grey background
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          TextButton.icon(
            style: buttonStyle,
            icon: Icon(Icons.view_column_outlined,
                size: iconSize, color: iconColor),
            label: const Text('Columns'),
            onPressed: () {
              // TODO: Implement Columns selection/visibility logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Columns Action Tapped (Not Implemented)'),
                    duration: Duration(seconds: 1)),
              );
            },
          ),
          const SizedBox(width: 16),
          TextButton.icon(
            style: buttonStyle,
            icon: Icon(Icons.filter_list, size: iconSize, color: iconColor),
            label: const Text('Filters'),
            onPressed: onFiltersPressed,
          ),
          const SizedBox(width: 16),
          TextButton.icon(
            style: buttonStyle,
            icon: Icon(Icons.save_alt, size: iconSize, color: iconColor),
            label: const Text('Export'),
            onPressed: () {
              // TODO: Implement Export (CSV/JSON) logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Export Action Tapped (Not Implemented)'),
                    duration: Duration(seconds: 1)),
              );
            },
          ),
        ],
      ),
    );
  }
}
