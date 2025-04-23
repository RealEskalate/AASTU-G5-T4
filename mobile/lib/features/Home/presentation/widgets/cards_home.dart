import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CardsHome extends StatefulWidget {
  final String text;
  final String extraText;
  final String digit;
  const CardsHome(
      {super.key,
      required this.text,
      this.extraText = '',
      required this.digit});

  @override
  State<CardsHome> createState() => _CardsHomeState();
}

class _CardsHomeState extends State<CardsHome> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Card(
          elevation: 5,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    widget.text,
                    style: GoogleFonts.publicSans(
                        fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(84, 214, 14, 0.16), // Dot color
                          shape: BoxShape.circle, // Makes it circular
                          border: Border.all(
                            color: Colors
                                .white, // Optional: white border for contrast
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/svgs/cards_svg_trend.svg',
                            width: 28,
                            height: 28,
                            color: Color.fromRGBO(84, 214, 14, 1),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          '0.0 %',
                          style: GoogleFonts.publicSans(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    widget.digit,
                    style: GoogleFonts.publicSans(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
