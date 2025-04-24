import 'package:flutter/material.dart';

// This widget is self-contained, only needing Flutter Material.
class ProblemTableCell extends StatelessWidget {
  final Widget child;
  final double width;
  final Alignment alignment;

  const ProblemTableCell({
    required this.child,
    required this.width,
    this.alignment = Alignment.centerLeft, // Default alignment
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // A Container to control width, alignment, and padding for each cell's content.
    return Container(
      width: width,
      height: double
          .infinity, // Takes the full height of the parent Row (ProblemRow)
      padding: const EdgeInsets.symmetric(
          horizontal: 8.0, vertical: 4.0), // Standard padding
      alignment:
          alignment, // Controls where the 'child' is positioned within the cell
      child: child, // The actual content (Text, Icon, Chip, etc.)
    );
  }
}
