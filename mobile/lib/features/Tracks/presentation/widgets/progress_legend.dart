import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressLegend extends StatelessWidget {
  final int solved;
  final int available;

  const ProgressLegend({
    Key? key,
    required this.solved,
    required this.available,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Solved problems
        Row(
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Solved',
              style: GoogleFonts.publicSans(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onBackground,
              ),
            ),
            const Spacer(),
            Text(
              '$solved Problems',
              style: GoogleFonts.publicSans(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onBackground,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Available problems
        Row(
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Available',
              style: GoogleFonts.publicSans(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onBackground,
              ),
            ),
            const Spacer(),
            Text(
              '$available Problems',
              style: GoogleFonts.publicSans(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onBackground,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
