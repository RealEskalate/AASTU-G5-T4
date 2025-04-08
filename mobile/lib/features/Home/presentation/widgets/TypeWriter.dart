import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TypewriterText extends StatefulWidget {
  final String text;
  final Duration speed;
  final TextStyle style;
  final double indentWidth;

  const TypewriterText({
    required this.text,
    this.speed = const Duration(milliseconds: 100),
    this.style = const TextStyle(),
    this.indentWidth = 20.0,
    Key? key,
  }) : super(key: key);

  @override
  _TypewriterTextState createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;
  late Timer _cursorTimer;
  bool _showCursor = true;
  final double _containerPadding = 16.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(
          milliseconds: widget.text.length * widget.speed.inMilliseconds),
      vsync: this,
    );

    _animation = IntTween(begin: 0, end: widget.text.length)
        .animate(_controller)
      ..addListener(() => setState(() {}));

    _controller.forward();

    _cursorTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_controller.isCompleted) {
        setState(() => _showCursor = !_showCursor);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _cursorTimer.cancel();
    super.dispose();
  }

  List<String> _getVisibleLines(
      String fullText, int visibleLength, BuildContext context) {
    final textSpan = TextSpan(
        text: fullText.substring(0, visibleLength), style: widget.style);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      maxLines: 100,
    );

    final maxWidth = MediaQuery.of(context).size.width * 0.9 -
        2 * _containerPadding -
        widget.indentWidth;
    textPainter.layout(maxWidth: maxWidth);

    List<String> lines = [];
    String remainingText = fullText.substring(0, visibleLength);

    while (remainingText.isNotEmpty) {
      final textSpan = TextSpan(text: remainingText, style: widget.style);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        maxLines: 1,
      );

      textPainter.layout(maxWidth: maxWidth);

      final end = textPainter.getPositionForOffset(Offset(maxWidth, 0)).offset;
      final line = remainingText.substring(0, end);
      lines.add(line);
      remainingText = remainingText.substring(end).trimLeft();
    }

    return lines;
  }

  @override
  Widget build(BuildContext context) {
    final visibleLines =
        _getVisibleLines(widget.text, _animation.value, context);

    return Center(
      child: Container(
        padding: EdgeInsets.all(_containerPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < visibleLines.length; i++)
              Padding(
                padding: EdgeInsets.only(left: i > 0 ? widget.indentWidth : 0),
                child: Text(
                  visibleLines[i],
                  style: GoogleFonts.publicSans(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                  textAlign: i == 0 ? TextAlign.center : TextAlign.center,
                ),
              ),
            if (_controller.isCompleted && visibleLines.isNotEmpty)
              AnimatedOpacity(
                opacity: _showCursor ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  width: 2,
                  height: widget.style.fontSize ?? 16,
                  margin: EdgeInsets.only(
                      left: visibleLines.length > 1 ? widget.indentWidth : 0),
                  color: widget.style.color ?? Colors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
