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
import 'package:mobile/features/Home/presentation/widgets/sideBar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String quote = "";
  bool isLoading = true;
  final DateTime targetDate = DateTime.now().add(const Duration(days: 7));
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // Create a sidebar controller
  final SidebarController _sidebarController = SidebarController();
  int _selectedIndex = 0;
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
      if (mounted) {
        setState(() {
          quote = "Failed to load quote"; // Fallback text
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      key: _scaffoldKey,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Customappbar(
            onMenuPressed: () {
              _sidebarController.toggleSidebar();
            },
          )),
      // drawer: HubSidebarExample(),
      body: Stack(children: [
        SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                // Customappbar(),
                Padding(
                  padding: const EdgeInsets.only(top: 29.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(20),
                      shape: BoxShape.rectangle,
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.15),
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
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.23,
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
                            onPressed: () => context.go('/problems'),
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
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Card(
                      elevation: 5,
                      color: Theme.of(context).colorScheme.surface,
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
                                              Icons.keyboard_arrow_left_rounded,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface)),
                                      Text('1/1',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface)),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                              Icons
                                                  .keyboard_arrow_right_rounded,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface)),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all(
                                          Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                      shape: WidgetStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      'Upcoming',
                                      style: GoogleFonts.publicSans(
                                          textStyle: TextStyle(
                                              fontSize: 13,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary,
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
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
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
                  ),
                )
              ],
            ),
          ),
        ),
        // Overlay sidebar when open
        ValueListenableBuilder<bool>(
          valueListenable: _sidebarController.sidebarVisibility,
          builder: (context, isVisible, _) {
            return AnimatedOpacity(
              opacity: isVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: isVisible
                  ? HubSidebar(
                      username: 'Natnael Wondwoesn Solomon',
                      userRole: 'Student',
                      userImageUrl:
                          'https://storage.googleapis.com/a2sv_hub_bucket_2/images%2FNatnael%20Wondwoesn%20Solomon.jpeg',
                      selectedIndex: _selectedIndex,
                      onItemSelected: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      onClose: _sidebarController.closeSidebar,
                    )
                  : const SizedBox.shrink(),
            );
          },
        ),
      ]),
    );
  }
}
