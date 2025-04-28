import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/features/Home/presentation/widgets/CustomappBar.dart';
import 'package:mobile/features/Home/presentation/widgets/sideBar.dart';
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
  // Create a sidebar controller
  final SidebarController _sidebarController = SidebarController();
  int _selectedIndex = 0;
  bool _showDetail = false;

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _sidebarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Customappbar(
            onMenuPressed: () {
              _sidebarController.toggleSidebar();
            },
          )),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
          child: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              // Profile header
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
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: theme.colorScheme.onBackground)),
                      ),
                      Row(
                        children: [
                          Text(
                            'Users',
                            style: GoogleFonts.publicSans(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: theme.colorScheme.onBackground)),
                          ),
                          Text(
                            ' . Natnael Wondwoesn Solomon',
                            style: GoogleFonts.publicSans(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: theme.colorScheme.onBackground
                                        .withOpacity(0.7))),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              // Main profile components
              ProfileCard(),
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
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Card(
                    elevation: 5,
                    color: theme.colorScheme.surface,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              '1215',
                              style: GoogleFonts.publicSans(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: theme.colorScheme.onSurface)),
                            ),
                            Text(
                              'Rating',
                              style: GoogleFonts.publicSans(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: theme.colorScheme.onSurface
                                          .withOpacity(0.7))),
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
                                color: theme.colorScheme.onSurface
                                    .withOpacity(0.2)),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              '365',
                              style: GoogleFonts.publicSans(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: theme.colorScheme.onSurface)),
                            ),
                            Text(
                              'Problems',
                              style: GoogleFonts.publicSans(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: theme.colorScheme.onSurface
                                          .withOpacity(0.7))),
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
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Card(
                    elevation: 5,
                    color: theme.colorScheme.surface,
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
                                color: theme.colorScheme.onSurface,
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'Next: Solver III',
                              style: GoogleFonts.publicSans(
                                  fontSize: 16,
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(0.7),
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
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Card(
                    elevation: 5,
                    color: theme.colorScheme.surface,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Div 3',
                          style: GoogleFonts.publicSans(
                              fontSize: 21,
                              color: theme.colorScheme.onSurface,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Division III',
                          style: GoogleFonts.publicSans(
                              fontSize: 16,
                              color:
                                  theme.colorScheme.onSurface.withOpacity(0.7),
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
        )
      ])),
    );
  }
}
