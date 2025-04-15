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
    return Container(
      width: MediaQuery.of(context).size.width * 0.9438,
      child: SingleChildScrollView(
        child: Card(
          elevation: 2,
          color: Colors.white,
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
                      )),
                    ),
                    // Year dropdown
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Text(
                            selectedYear.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 18,
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
                              color: Colors.grey.shade600,
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
                            color: Colors.grey.shade600,
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
                                          color:
                                              _getColorForIntensity(intensity),
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
                                              color: Colors.yellow,
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
                    const Text(
                      'Less',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
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
                          color: _getColorForIntensity(index),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'More',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
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
  Color _getColorForIntensity(int intensity) {
    switch (intensity) {
      case 0:
        return Color.fromRGBO(238, 238, 238, 1); // No activity
      case 1:
        return Color.fromRGBO(200, 250, 205, 1); // Light green
      case 2:
        return const Color.fromRGBO(91, 229, 132, 1); // Medium green
      case 3:
        return const Color.fromRGBO(0, 171, 85, 1); // Dark green
      case 4:
        return const Color.fromRGBO(0, 82, 73, 1); // Very dark green
      default:
        return Colors.grey.shade200;
    }
  }
}
