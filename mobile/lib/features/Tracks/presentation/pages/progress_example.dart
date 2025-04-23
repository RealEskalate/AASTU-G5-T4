import 'package:flutter/material.dart';
import 'progress_screen.dart';

class ProgressExample extends StatelessWidget {
  const ProgressExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Demo data
    const int solvedProblems = 150;
    const int availableProblems = 72;
    const int totalProblems = 222;

    return const ProgressScreen(
      solved: solvedProblems,
      available: availableProblems,
      total: totalProblems,
    );
  }
}
