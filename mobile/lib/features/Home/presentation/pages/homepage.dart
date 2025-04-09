import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        print(fetchedQuote);
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () {
                  // Handle menu button press
                },
              ),
              SizedBox(
                width: 1,
              ),
              IconButton(
                icon: const Icon(Icons.search, color: Colors.black),
                onPressed: () {
                  // Handle search button press
                },
              )
            ],
          ),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.star,
                    color: Colors.amber,
                  )),
              Stack(children: [
                IconButton(
                  onPressed: () {},
                  icon: FaIcon(FontAwesomeIcons.solidBell),
                ),
                Positioned(
                    top: 1,
                    right: 2,
                    child: Card(
                      elevation: 10,
                      child: Container(
                        width: 20, // Dot size
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.red, // Dot color
                          shape: BoxShape.circle, // Makes it circular
                          border: Border.all(
                            color: Colors
                                .white, // Optional: white border for contrast
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '6',
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800)),
                          ),
                        ),
                      ),
                    ))
              ]),
              Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: GestureDetector(
                    onTap: () {},
                    child: Image.network(
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                        'https://storage.googleapis.com/a2sv_hub_bucket_2/images%2FNatnael%20Wondwoesn%20Solomon.jpeg'),
                  ),
                ),
                Positioned(
                    right: 2,
                    bottom: 0.01,
                    child: Container(
                      width: 16, // Dot size
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.green, // Dot color
                        shape: BoxShape.circle, // Makes it circular
                        border: Border.all(
                          color: Colors
                              .white, // Optional: white border for contrast
                          width: 2,
                        ),
                      ),
                    ))
              ])
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 29.0),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromRGBO(200, 250, 205, 1)),
                      borderRadius: BorderRadius.circular(20),
                      shape: BoxShape.rectangle,
                      color: Color.fromRGBO(200, 250, 205, 1)),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.57,
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: isLoading
                                ? Center(child: Text("|"))
                                : Center(
                                    child: TypewriterText(text: quote),
                                  ),
                          ),
                          Column(
                            children: [
                              Text('Welcome Back,',
                                  style: GoogleFonts.publicSans(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w400))),
                              Text('Natnael',
                                  style: GoogleFonts.publicSans(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w400))),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all(
                                          Color.fromRGBO(0, 171, 85, 1)),
                                      shape: WidgetStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              8), // Adjust the radius here
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      'Problems',
                                      style: GoogleFonts.publicSans(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700)),
                                    )),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: SvgPicture.asset(
                              'assets/svgs/homepage_1.svg',
                              width: 200,
                              height: 200,
                            ),
                          ),
                        ],
                      ),
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
