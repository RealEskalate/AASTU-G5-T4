import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

// Updated quote container widget
class QuoteContainer extends StatelessWidget {
  final String quote;
  final bool isLoading;
  final Function() onProblemsTap;

  const QuoteContainer({
    Key? key,
    required this.quote,
    required this.isLoading,
    required this.onProblemsTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(200, 250, 205, 1)),
        borderRadius: BorderRadius.circular(20),
        shape: BoxShape.rectangle,
        color: const Color.fromRGBO(200, 250, 205, 1),
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      // Make the height adaptive instead of fixed
      constraints: BoxConstraints(
        minHeight: 200,
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Important to avoid overflow
        children: [
          // Quote section with proper constraints
          Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.25,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : TypewriterTextSimplified(text: quote),
          ),

          // Welcome text
          Text('Welcome Back,',
              style: GoogleFonts.publicSans(
                  textStyle: const TextStyle(fontWeight: FontWeight.w400))),
          Text('Natnael',
              style: GoogleFonts.publicSans(
                  textStyle: const TextStyle(fontWeight: FontWeight.w400))),
          const SizedBox(height: 5),

          // Problems button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromRGBO(0, 171, 85, 1)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              onPressed: onProblemsTap,
              child: Text(
                'Problems',
                style: GoogleFonts.publicSans(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),

          // SVG image with flexible sizing
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SvgPicture.asset(
                'assets/svgs/homepage_1.svg',
                fit: BoxFit.contain,
                // Responsive width and height
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.15,
              ),
            ),
          ),

          // Warning stripe at bottom
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: const BoxDecoration(
              color: Colors.yellow,
              border: Border(
                top: BorderSide(color: Colors.black, width: 1),
                bottom: BorderSide(color: Colors.black, width: 1),
              ),
            ),
            child: const Center(
              child: Text(
                "BOTTOM OVERFLOW BY 34 PIXELS",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Simple version of TypewriterText for demonstration
class TypewriterTextSimplified extends StatelessWidget {
  final String text;

  const TypewriterTextSimplified({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.publicSans(
        textStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
      maxLines: 6,
      overflow: TextOverflow.ellipsis,
    );
  }
}
