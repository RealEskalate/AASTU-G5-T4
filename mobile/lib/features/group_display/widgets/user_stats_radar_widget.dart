import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Import fl_chart

class UserStatsRadarWidget extends StatelessWidget {
  final String profileImageUrl; // Can be network URL or local asset path
  final List<String> titleImageUrls; // List of badge/title image URLs/paths
  final List<String>
      statLabels; // e.g., ['Attendance', 'Consistency', 'Stat3', 'Stat4']
  final List<double>
      statsData; // e.g., [99.9, 53.4, 78.7, 78.7] - MUST match statLabels length

  const UserStatsRadarWidget({
    super.key,
    required this.profileImageUrl,
    required this.titleImageUrls,
    required this.statLabels,
    required this.statsData,
  }) : assert(statLabels.length == statsData.length,
            'Stat labels and data must have the same length');

  // Placeholder for title badges - adjust size and spacing as needed
  Widget _buildTitleBadges() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: titleImageUrls
          .map((url) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Image.asset(url,
                    height: 30, width: 30), // Assuming local assets for now
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    // Basic RadarChartData setup - Requires customization based on fl_chart docs
    // and the specific look you want.
    final radarChartData = RadarChartData(
      dataSets: [
        RadarDataSet(
          dataEntries:
              statsData.map((value) => RadarEntry(value: value)).toList(),
          fillColor: Colors.green.withOpacity(0.4), // Example color
          borderColor: Colors.green, // Example color
          entryRadius: 3,
          borderWidth: 2,
        ),
      ],
      radarBackgroundColor: Colors.transparent,
      borderData: FlBorderData(show: false), // Hide outer border
      radarBorderData:
          const BorderSide(color: Colors.grey, width: 1), // Axis lines
      gridBorderData:
          const BorderSide(color: Colors.grey, width: 1), // Grid lines
      tickBorderData:
          const BorderSide(color: Colors.transparent), // Hide ticks border
      ticksTextStyle: const TextStyle(
          color: Colors.transparent, fontSize: 10), // Hide tick labels
      tickCount: 5, // Example number of grid circles
      getTitle: (index, angle) {
        // Check if index is valid before accessing statLabels
        if (index < 0 || index >= statLabels.length) {
          return const RadarChartTitle(
              text: ''); // Return empty title for invalid index
        }
        final label = statLabels[index];

        // Return the basic text label for the title
        return RadarChartTitle(text: label, angle: angle);
      },
      titlePositionPercentageOffset:
          0.2, // Adjust distance of titles from chart
      titleTextStyle:
          textTheme.labelMedium!, // Style for the text returned by getTitle
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top Row: Profile Pic, Titles
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage:
                    AssetImage(profileImageUrl), // Assuming local asset
                // Or NetworkImage(profileImageUrl) for network images
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Titles', style: textTheme.titleMedium),
                    const SizedBox(height: 4),
                    _buildTitleBadges(),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Radar Chart
          AspectRatio(
            // Maintain aspect ratio for the chart
            aspectRatio: 1.3, // Adjust aspect ratio as needed
            child: RadarChart(radarChartData),
          ),
        ],
      ),
    );
  }

  // Helper to create the green value chip - Keep this for manual positioning later
  Widget _buildValueChip(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        value,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
