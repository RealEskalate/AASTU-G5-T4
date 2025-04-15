import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/core/extras/quotes.dart';
import 'package:mobile/features/Home/presentation/widgets/CustomappBar.dart';
import 'package:mobile/features/Home/presentation/widgets/TypeWriter.dart';
import 'package:mobile/features/Home/presentation/widgets/cards_home.dart';
import 'package:mobile/features/Home/presentation/widgets/countDownTimer.dart';
import 'package:mobile/features/Home/presentation/widgets/dailyProblems.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String quote = "";
  bool isLoading = true;
  final DateTime targetDate = DateTime.now().add(const Duration(days: 7));

  @override
  void initState() {
    super.initState();
    loadQuote();
  }

  Future<void> loadQuote() async {
    try {
      final fetchedQuote = await GetQuotesFunc();
      setState(() {
        // print(fetchedQuote);
        quote = fetchedQuote;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        quote = "Failed to load quote"; // Fallback text
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Customappbar(),
              Padding(
                padding: const EdgeInsets.only(top: 29.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromRGBO(200, 250, 205, 1)),
                    borderRadius: BorderRadius.circular(20),
                    shape: BoxShape.rectangle,
                    color: const Color.fromRGBO(200, 250, 205, 1),
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  // Make the height adaptive instead of fixed
                  constraints: BoxConstraints(
                    minHeight: 100,
                    maxHeight: MediaQuery.of(context).size.height * 0.6,
                  ),
                  child: Column(
                    mainAxisSize:
                        MainAxisSize.min, // Important to avoid overflow
                    children: [
                      // Quote section with proper constraints
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.2,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : TypewriterText(text: quote),
                      ),

                      // Welcome text
                      Text('Welcome Back,',
                          style: GoogleFonts.publicSans(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w400))),
                      Text('Natnael',
                          style: GoogleFonts.publicSans(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w400))),
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
                          onPressed: () => context.go('/profile'),
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
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              CardsHome(text: 'Solutions', digit: '406'),
              CardsHome(text: 'Time Spent', digit: '11,979'),
              CardsHome(text: 'Rating', digit: '980'),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LeetcodeCard(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 10),
                    child: Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                          Icons.keyboard_arrow_left_rounded)),
                                  Text('1/1'),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                          Icons.keyboard_arrow_right_rounded)),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      Color.fromRGBO(31, 144, 250, 1)),
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20), // Adjust the radius here
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  'Upcoming',
                                  style: GoogleFonts.publicSans(
                                      textStyle: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                'uytutr',
                                style: GoogleFonts.publicSans(
                                    textStyle: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700)),
                              ),
                              CountdownWithTarget(targetDate: targetDate)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
