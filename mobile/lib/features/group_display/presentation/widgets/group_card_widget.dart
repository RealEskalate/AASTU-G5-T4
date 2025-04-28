import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class GroupCardWidget extends StatelessWidget {
  final String groupName;
  final String groupAbbreviation;
  final int memberCount;
  final String timeSpent; // Using String for flexibility, could be Duration/int
  final String avgRating; // Using String for flexibility, could be double/int

  const GroupCardWidget({
    super.key,
    required this.groupName,
    required this.groupAbbreviation,
    required this.memberCount,
    required this.timeSpent,
    required this.avgRating,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => context.go('/group_details'),
      child: Card(
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Make card height fit content
              children: [
                Text(
                  groupName, // Use parameter
                  style: GoogleFonts.publicSans(
                    textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: colorScheme.onSurface),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$groupAbbreviation • $memberCount Members', // Use parameters
                  style: GoogleFonts.publicSans(
                    textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: colorScheme.onSurface.withOpacity(0.6)),
                  ),
                ),
                const SizedBox(height: 170), // Add some space before the stats
                IntrinsicHeight(
                  // Ensures the divider takes the full height of the row
                  child: Row(
                    children: [
                      VerticalDivider(
                        width: 20,
                        thickness: 4,
                        indent: 5, // Optional top padding for divider
                        endIndent: 5, // Optional bottom padding for divider
                        color: colorScheme.surfaceVariant,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Time Spent',
                              style: GoogleFonts.publicSans(
                                  textStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: colorScheme.onSurface
                                          .withOpacity(0.8))),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              timeSpent, // Use parameter
                              style: GoogleFonts.publicSans(
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: colorScheme.onSurface)),
                            ),
                          ],
                        ),
                      ),
                      VerticalDivider(
                        width: 20,
                        thickness: 4,
                        indent: 5, // Optional top padding for divider
                        endIndent: 5, // Optional bottom padding for divider
                        color: colorScheme.surfaceVariant,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Avg. Rating',
                              style: GoogleFonts.publicSans(
                                  textStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: colorScheme.onSurface
                                          .withOpacity(0.8))),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              avgRating, // Use parameter
                              style: GoogleFonts.publicSans(
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: colorScheme.onSurface)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
