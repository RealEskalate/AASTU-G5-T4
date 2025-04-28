import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TypewriterText extends StatefulWidget {
  final String text;
  final Duration speed;
  final TextStyle style;
  final double indentWidth;
  final int maxLines;
  final TextAlign textAlign;

  const TypewriterText({
    required this.text,
    this.speed = const Duration(milliseconds: 100),
    this.style = const TextStyle(),
    this.indentWidth = 20.0,
    this.maxLines = 5, // Limited max lines
    this.textAlign = TextAlign.center, // Default center alignment
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

  @override
  Widget build(BuildContext context) {
    final visibleText = widget.text.substring(0, _animation.value);

    return Center(
      child: Container(
        padding: EdgeInsets.all(0),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              textAlign: widget.textAlign,
              overflow: TextOverflow.ellipsis,
              maxLines: widget.maxLines,
              text: TextSpan(
                text: visibleText,
                style: GoogleFonts.publicSans(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            if (_controller.isCompleted)
              AnimatedOpacity(
                opacity: _showCursor ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  width: 2,
                  height: 20, // Fixed height
                  color: Colors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
