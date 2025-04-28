import 'package:flutter/material.dart';
import 'dart:math';

import 'package:google_fonts/google_fonts.dart';

class ConsistencyCalendarWidget extends StatefulWidget {
  const ConsistencyCalendarWidget({Key? key}) : super(key: key);

  @override
  State<ConsistencyCalendarWidget> createState() =>
      _ConsistencyCalendarWidgetState();
}

class _ConsistencyCalendarWidgetState extends State<ConsistencyCalendarWidget> {
  final List<String> weekdays = ['Mon', 'Wed', 'Fri'];
  final List<String> months = ['Jan', 'Feb', 'Mar', 'Apr'];
  int selectedYear = 2025;
  // Sample data: intensity levels from 0 to 4 for each cell
  // 0 = no activity, 1-4 = increasing activity
  late List<List<int>> activityData;
  // Special marker for certain dates (highlighted with a circle)
  late Set<String> highlightedDates;

  @override
  void initState() {
    super.initState();
    // Generate random activity data
    activityData = List.generate(
      3, // 3 rows for Mon, Wed, Fri
      (_) => List.generate(
        16, // 4 months with 4 cells each
        (_) => Random().nextInt(5), // Random intensity between 0-4
      ),
    );

    // Set a specific date to be highlighted with a circle
    highlightedDates = {'2-3-1'}; // Format: "row-month-week"
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: MediaQuery.of(context).size.width * 0.9438,
      child: SingleChildScrollView(
        child: Card(
          elevation: 2,
          color: theme.colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with title and year dropdown
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Consistency',
                      style: GoogleFonts.publicSans(
                          textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      )),
                    ),
                    // Year dropdown
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color:
                                theme.colorScheme.onSurface.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Text(
                            selectedYear.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_drop_down,
                            size: 18,
                            color: theme.colorScheme.onSurface,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Month labels
                Row(
                  children: [
                    // Spacer for the weekday column
                    SizedBox(width: 36),
                    ...months.map((month) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            month,
                            style: TextStyle(
                              fontSize: 12,
                              color:
                                  theme.colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 8),

                // Activity grid
                for (int rowIndex = 0; rowIndex < weekdays.length; rowIndex++)
                  Row(
                    children: [
                      // Weekday label
                      SizedBox(
                        width: 36,
                        child: Text(
                          weekdays[rowIndex],
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ),

                      // Grid cells for each month
                      for (int monthIndex = 0;
                          monthIndex < months.length;
                          monthIndex++)
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                              4, // 4 cells per month
                              (weekIndex) {
                                final cellIndex = monthIndex * 4 + weekIndex;
                                final intensity =
                                    cellIndex < activityData[rowIndex].length
                                        ? activityData[rowIndex][cellIndex]
                                        : 0;

                                // Check if this date is highlighted
                                final isHighlighted = highlightedDates.contains(
                                    '$rowIndex-$monthIndex-$weekIndex');

                                return Container(
                                  margin: const EdgeInsets.all(2),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      // Activity cell
                                      Container(
                                        width: 14,
                                        height: 14,
                                        decoration: BoxDecoration(
                                          color: _getColorForIntensity(
                                              intensity, theme),
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                      ),

                                      // Highlight circle (if applicable)
                                      if (isHighlighted)
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color:
                                                  theme.colorScheme.secondary,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                const SizedBox(height: 16),

                // Legend
                Row(
                  children: [
                    Text(
                      'Less',
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(width: 4),
                    ...List.generate(
                      5,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: _getColorForIntensity(index, theme),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'More',
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to get colors based on intensity
  Color _getColorForIntensity(int intensity, ThemeData theme) {
    final bool isDarkMode = theme.brightness == Brightness.dark;

    switch (intensity) {
      case 0:
        return isDarkMode
            ? theme.colorScheme.onSurface.withOpacity(0.12)
            : const Color.fromRGBO(238, 238, 238, 1); // No activity
      case 1:
        return isDarkMode
            ? const Color.fromRGBO(50, 125, 75, 1)
            : const Color.fromRGBO(200, 250, 205, 1); // Light green
      case 2:
        return isDarkMode
            ? const Color.fromRGBO(60, 150, 90, 1)
            : const Color.fromRGBO(91, 229, 132, 1); // Medium green
      case 3:
        return isDarkMode
            ? const Color.fromRGBO(30, 180, 100, 1)
            : const Color.fromRGBO(0, 171, 85, 1); // Dark green
      case 4:
        return isDarkMode
            ? const Color.fromRGBO(0, 200, 100, 1)
            : const Color.fromRGBO(0, 82, 73, 1); // Very dark green
      default:
        return isDarkMode
            ? theme.colorScheme.onSurface.withOpacity(0.1)
            : Colors.grey.shade200;
    }
  }
}
