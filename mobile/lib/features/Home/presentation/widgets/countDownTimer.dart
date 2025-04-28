// import 'package:flutter/material.dart';
// import 'dart:async';

// import 'package:google_fonts/google_fonts.dart';

// class CountdownTimer extends StatefulWidget {
//   final DateTime targetDate;

//   const CountdownTimer({Key? key, required this.targetDate}) : super(key: key);

//   @override
//   _CountdownTimerState createState() => _CountdownTimerState();
// }

// class _CountdownTimerState extends State<CountdownTimer> {
//   late Timer _timer;
//   Duration _remainingTime = Duration.zero;

//   @override
//   void initState() {
//     super.initState();
//     _calculateRemainingTime();
//     _startTimer();
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   void _calculateRemainingTime() {
//     final now = DateTime.now();
//     if (widget.targetDate.isAfter(now)) {
//       setState(() {
//         _remainingTime = widget.targetDate.difference(now);
//       });
//     } else {
//       setState(() {
//         _remainingTime = Duration.zero;
//       });
//     }
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       _calculateRemainingTime();
//     });
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');

//     final days = duration.inDays;
//     final hours = duration.inHours % 24;
//     final minutes = duration.inMinutes % 60;
//     final seconds = duration.inSeconds % 60;

//     return '${days}d ${twoDigits(hours)}h ${twoDigits(minutes)}m ${twoDigits(seconds)}s';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Text(_formatDuration(_remainingTime),
//         style: GoogleFonts.publicSans(
//           textStyle: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Color.fromRGBO(0, 123, 85, 1),
//           ),
//         ));
//   }
// }
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';

class CountdownWithTarget extends StatefulWidget {
  final DateTime targetDate;

  const CountdownWithTarget({Key? key, required this.targetDate})
      : super(key: key);

  @override
  _CountdownWithTargetState createState() => _CountdownWithTargetState();
}

class _CountdownWithTargetState extends State<CountdownWithTarget> {
  late Timer _timer;
  Duration _remainingTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _calculateRemainingTime();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _calculateRemainingTime() {
    final now = DateTime.now();
    setState(() {
      _remainingTime = widget.targetDate.isAfter(now)
          ? widget.targetDate.difference(now)
          : Duration.zero;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _calculateRemainingTime();
    });
  }

  String _formatDuration(Duration d) {
    return '${d.inDays}d ${(d.inHours % 24).toString().padLeft(2, '0')}h '
        '${(d.inMinutes % 60).toString().padLeft(2, '0')}m '
        '${(d.inSeconds % 60).toString().padLeft(2, '0')}s';
  }

  String _formatTargetDate(DateTime date) {
    return '${_getWeekday(date)} ${_getMonth(date)} ${date.day}  | '
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  String _getWeekday(DateTime date) {
    return ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][date.weekday % 7];
  }

  String _getMonth(DateTime date) {
    return [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ][date.month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Countdown Timer
          Text(
            _formatDuration(_remainingTime),
            style: GoogleFonts.publicSans(
              textStyle: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 5),
          // Target Date Display
          const SizedBox(height: 1),
          Text(
            _formatTargetDate(widget.targetDate),
            // textAlign: TextAlign.center,
            style: GoogleFonts.publicSans(
                textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            )),
          ),
        ],
      ),
    );
  }
}
