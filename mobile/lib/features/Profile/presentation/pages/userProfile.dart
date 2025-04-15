import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/features/Home/presentation/widgets/CustomappBar.dart';
import 'package:mobile/features/Profile/presentation/widgets/about_card.dart';
import 'package:mobile/features/Profile/presentation/widgets/attendance_heatmap.dart';
import 'package:mobile/features/Profile/presentation/widgets/profileCard.dart';
import 'package:mobile/features/Profile/presentation/widgets/consistency_calendar.dart';
import 'package:mobile/features/Profile/presentation/widgets/social_links.dart';

class UserprofilePage extends StatefulWidget {
  const UserprofilePage({super.key});

  @override
  State<UserprofilePage> createState() => _UserprofilePageState();
}

class _UserprofilePageState extends State<UserprofilePage> {
  bool _showDetail = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Customappbar(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profile',
                      style: GoogleFonts.publicSans(
                          textStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700)),
                    ),
                    Row(
                      children: [
                        Text(
                          'Users',
                          style: GoogleFonts.publicSans(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(33, 43, 54, 1))),
                        ),
                        Text(
                          ' . Natnael Wondwoesn Solomon',
                          style: GoogleFonts.publicSans(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(145, 158, 171, 1))),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            ProfileCard(),
            // Calendar And The Rest
            ConsistencyCalendarWidget(),
            // Attendance Heatmap
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AttendanceHeatmap(
                attendanceRecords: generateSampleData(),
                showDetail: _showDetail,
                onToggleDetail: (value) {
                  setState(() {
                    _showDetail = value;
                  });
                },
              ),
            ),
            // Extras
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Card(
                  elevation: 5,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            '1215',
                            style: GoogleFonts.publicSans(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20)),
                          ),
                          Text(
                            'Rating',
                            style: GoogleFonts.publicSans(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(99, 115, 129, 1))),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 0,
                        child: Text(
                          "|",
                          style: GoogleFonts.publicSans(
                              fontSize: 100,
                              fontWeight: FontWeight.w100,
                              color: Colors.grey[100]),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            '365',
                            style: GoogleFonts.publicSans(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20)),
                          ),
                          Text(
                            'Problems',
                            style: GoogleFonts.publicSans(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(99, 115, 129, 1))),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Card(
                  elevation: 5,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            width: 158,
                            height: 178.21,
                            'https://hub.a2sv.org/illustrations/titles/coder.png',
                          ),
                        ),
                        Text(
                          'Coder I · 980',
                          style: GoogleFonts.publicSans(
                              fontSize: 21,
                              color: Color.fromRGBO(33, 43, 54, 1),
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Next: Solver III',
                            style: GoogleFonts.publicSans(
                                fontSize: 16,
                                color: Color.fromRGBO(99, 115, 129, 1),
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Card(
                  elevation: 5,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Div 3',
                        style: GoogleFonts.publicSans(
                            fontSize: 21,
                            color: Color.fromRGBO(33, 43, 54, 1),
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Division III',
                        style: GoogleFonts.publicSans(
                            fontSize: 16,
                            color: Color.fromRGBO(99, 115, 129, 1),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // About Card
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AboutCardExample(),
            ),

            // Social Links
            Padding(
              padding: EdgeInsets.all(8),
              child: SocialLinksExample(),
            )
          ],
        ),
      )),
    );
  }
}
