import 'package:flutter/material.dart';
import 'dart:math';

class DiamondRatingChart extends StatelessWidget {
  final double performance;
  final double experience;
  final double consistency;
  final double
      fourthMetric; // You can rename this based on what the 4th category is
  final Color fillColor;
  final Color borderColor;
  // final Color backgroundColor = ;
  final List<String> labels;
  final List<Widget>? titleIcons;

  const DiamondRatingChart({
    Key? key,
    required this.performance,
    required this.experience,
    required this.consistency,
    required this.fourthMetric,
    this.fillColor =
        const Color(0xFF90EEB7), // Light green color from the image
    this.borderColor = const Color(0xFF90EEB7),
    // this.backgroundColor = Theme.of(context).colorScheme.surface,
    this.labels = const [
      'Performance',
      'Experience',
      'Consistency',
      'Fourth Metric'
    ],
    this.titleIcons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title icons if provided
        if (titleIcons != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...titleIcons!
                    .map((icon) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: icon,
                        ))
                    .toList(),
              ],
            ),
          ),

        // Main diamond chart
        AspectRatio(
          aspectRatio: 1.0,
          child: CustomPaint(
            painter: DiamondRatingPainter(
              performance: performance,
              experience: experience,
              consistency: consistency,
              fourthMetric: fourthMetric,
              fillColor: fillColor,
              borderColor: borderColor,
              backgroundColor: Theme.of(context).colorScheme.surface,
              labels: labels,
            ),
          ),
        ),
      ],
    );
  }
}

class DiamondRatingPainter extends CustomPainter {
  final double performance;
  final double experience;
  final double consistency;
  final double fourthMetric;
  final Color fillColor;
  final Color borderColor;
  final Color backgroundColor;
  final List<String> labels;

  DiamondRatingPainter({
    required this.performance,
    required this.experience,
    required this.consistency,
    required this.fourthMetric,
    required this.fillColor,
    required this.borderColor,
    required this.backgroundColor,
    required this.labels,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;

    // Draw background
    _drawBackground(canvas, center, radius);

    // Draw grid lines
    _drawGridLines(canvas, center, radius);

    // Draw data polygon
    _drawDataPolygon(canvas, center, radius);

    // Draw labels
    _drawLabels(canvas, center, radius);

    // Draw scores
    _drawScores(canvas, center, radius);
  }

  void _drawBackground(Canvas canvas, Offset center, double radius) {
    final outerBackgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    // Draw outer background as a diamond shape
    final outerPath = Path();
    // Top point
    outerPath.moveTo(center.dx, center.dy - radius);
    // Right point
    outerPath.lineTo(center.dx + radius, center.dy);
    // Bottom point
    outerPath.lineTo(center.dx, center.dy + radius);
    // Left point
    outerPath.lineTo(center.dx - radius, center.dy);
    outerPath.close();

    canvas.drawPath(outerPath, outerBackgroundPaint);
  }

  void _drawGridLines(Canvas canvas, Offset center, double radius) {
    // Draw grid lines
    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Draw diamond grid lines at 25%, 50%, 75%, and 100%
    for (int i = 1; i <= 4; i++) {
      final gridRadius = radius * i / 4;
      final gridPath = Path();

      // Top point
      gridPath.moveTo(center.dx, center.dy - gridRadius);
      // Right point
      gridPath.lineTo(center.dx + gridRadius, center.dy);
      // Bottom point
      gridPath.lineTo(center.dx, center.dy + gridRadius);
      // Left point
      gridPath.lineTo(center.dx - gridRadius, center.dy);
      gridPath.close();

      canvas.drawPath(gridPath, gridPaint);
    }

    // Draw axis lines
    final axisPaint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Vertical axis
    canvas.drawLine(
      Offset(center.dx, center.dy - radius),
      Offset(center.dx, center.dy + radius),
      axisPaint,
    );

    // Horizontal axis
    canvas.drawLine(
      Offset(center.dx - radius, center.dy),
      Offset(center.dx + radius, center.dy),
      axisPaint,
    );
  }

  void _drawDataPolygon(Canvas canvas, Offset center, double radius) {
    // Calculate points based on values
    final performancePoint = Offset(
      center.dx,
      center.dy - (radius * performance / 100),
    );

    final experiencePoint = Offset(
      center.dx + (radius * experience / 100),
      center.dy,
    );

    final consistencyPoint = Offset(
      center.dx,
      center.dy + (radius * consistency / 100),
    );

    final fourthMetricPoint = Offset(
      center.dx - (radius * fourthMetric / 100),
      center.dy,
    );

    // Draw data polygon
    final dataPath = Path();
    dataPath.moveTo(performancePoint.dx, performancePoint.dy);
    dataPath.lineTo(experiencePoint.dx, experiencePoint.dy);
    dataPath.lineTo(consistencyPoint.dx, consistencyPoint.dy);
    dataPath.lineTo(fourthMetricPoint.dx, fourthMetricPoint.dy);
    dataPath.close();

    // Fill data polygon
    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(dataPath, fillPaint);

    // Draw border
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawPath(dataPath, borderPaint);
  }

  void _drawLabels(Canvas canvas, Offset center, double radius) {
    final labelDistance = radius + 15; // Give some margin for the labels
    final labelStyle = TextStyle(
      color: Colors.grey[500],
      fontSize: 12,
    );

    // Performance (top)
    _drawTextCentered(
      canvas,
      labels[0],
      Offset(center.dx, center.dy - labelDistance),
      labelStyle,
    );

    // Experience (right)
    _drawTextCentered(
      canvas,
      labels[1],
      Offset(center.dx + labelDistance, center.dy),
      labelStyle,
    );

    // Consistency (bottom)
    _drawTextCentered(
      canvas,
      labels[2],
      Offset(center.dx, center.dy + labelDistance),
      labelStyle,
    );

    // Fourth Metric (left)
    _drawTextCentered(
      canvas,
      labels[3],
      Offset(center.dx - labelDistance, center.dy),
      labelStyle,
    );
  }

  void _drawScores(Canvas canvas, Offset center, double radius) {
    final scoreDistance =
        radius * 0.5; // Place scores at 75% of the way to the edge
    final scoreStyle = TextStyle(
      color: Colors.grey[500],
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );

    // Performance (top)
    _drawTextCentered(
      canvas,
      '${performance.toInt()}',
      Offset(center.dx, center.dy - scoreDistance),
      scoreStyle,
    );

    // Experience (right)
    _drawTextCentered(
      canvas,
      '${experience.toInt()}',
      Offset(center.dx + scoreDistance, center.dy),
      scoreStyle,
    );

    // Consistency (bottom)
    _drawTextCentered(
      canvas,
      '${consistency.toInt()}',
      Offset(center.dx, center.dy + scoreDistance),
      scoreStyle,
    );

    // Fourth Metric (left)
    _drawTextCentered(
      canvas,
      '${fourthMetric.toInt()}',
      Offset(center.dx - scoreDistance, center.dy),
      scoreStyle,
    );
  }

  void _drawTextCentered(
      Canvas canvas, String text, Offset position, TextStyle style) {
    final textSpan = TextSpan(
      text: text,
      style: style,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    textPainter.layout();

    final xCenter = position.dx - textPainter.width / 2;
    final yCenter = position.dy - textPainter.height / 2;
    final offset = Offset(xCenter, yCenter);

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// DiamondRatingChart(
//           performance: 89.5,  // Based on your image
//           experience: 78.7,   // Based on your image
//           consistency: 83.4,  // Based on your image
//           fourthMetric: 78.7, // Based on your image
//           titleIcons: titleIcons,
//           labels: ['Performance', 'Experience', 'Consistency', 'Fourth Metric'],
//         ),
