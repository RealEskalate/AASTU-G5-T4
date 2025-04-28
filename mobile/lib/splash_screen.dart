import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

// Splash Screen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Set up fade animation
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();

    // Navigate to /home after 5 seconds
    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
        context.go('/home');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/svgs/vercel_logo.svg'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError || !snapshot.hasData) {
                return Text(
                  'Failed to load logo',
                  style: TextStyle(color: Colors.red, fontSize: 20),
                );
              }
              return FadeTransition(
                opacity: _animation,
                child: Image.asset(
                  'assets/hub.png',
                  width: 200,
                  height: 200,
                  // placeholderBuilder: (context) => CircularProgressIndicator(),
                  // semanticsLabel: 'Vercel Logo',
                ),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
