import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/progress_circle.dart';
import '../widgets/progress_legend.dart';
import '../widgets/action_buttons.dart';

class ProgressScreen extends StatelessWidget {
  final int solved;
  final int available;
  final int total;

  const ProgressScreen({
    Key? key,
    required this.solved,
    required this.available,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 'Tracks' header
                        Text(
                          'Tracks',
                          style: GoogleFonts.publicSans(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        // 'All' subheader
                        Text(
                          'All',
                          style: GoogleFonts.publicSans(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(145, 158, 171, 1),
                          ),
                        ),

                        // Progress header
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Progress',
                                style: GoogleFonts.publicSans(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.arrow_upward,
                                      size: 20,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '49',
                                    style: GoogleFonts.publicSans(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.arrow_downward,
                                      size: 20,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.message_outlined,
                                      size: 20,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Progress Circle
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: ProgressCircle(
                              solved: solved,
                              total: total,
                              displayMode: ProgressDisplayMode.count,
                              onSettingsTap: () {
                                // Handle settings tap
                              },
                            ),
                          ),
                        ),

                        // Legend
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ProgressLegend(
                            solved: solved,
                            available: available,
                          ),
                        ),

                        // Flexible space
                        Expanded(child: SizedBox()),

                        // Action Buttons
                        ActionButtons(
                          onExerciseTap: () {
                            // Handle exercise tap
                          },
                          onProblemsTap: () {
                            // Handle problems tap
                          },
                        ),
                        const SizedBox(height: 10),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.95,
                              child: Card(
                                color: Colors.white,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            // Smaller circle with percentage display
                                            ProgressCircle(
                                              solved: 150,
                                              total: 300,
                                              size: 80,
                                              displayMode:
                                                  ProgressDisplayMode.percent,
                                              strokeWidth: 8,
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  '150',
                                                  style: GoogleFonts.publicSans(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  'Solved',
                                                  style: GoogleFonts.publicSans(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            )

                                            // Another smaller circle with count display
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 60),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ProgressCircle(
                                              solved: 32,
                                              total: 100,
                                              size: 80,
                                              displayMode:
                                                  ProgressDisplayMode.percent,
                                              strokeWidth: 8,
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  '75',
                                                  style: GoogleFonts.publicSans(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  'Availble',
                                                  style: GoogleFonts.publicSans(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
