import 'package:flutter/material.dart';

class SolvedStatus extends StatelessWidget {
  final bool solved;

  const SolvedStatus({required this.solved, super.key});

  @override
  Widget build(BuildContext context) {
    if (solved) {
      return Icon(Icons.check_circle, color: Colors.green.shade600, size: 20);
    } else {
      return Text(
        '-',
        style: TextStyle(color: Theme.of(context).disabledColor),
        textAlign: TextAlign.center,
      );
    }
  }
}
