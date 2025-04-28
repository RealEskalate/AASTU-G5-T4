import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/features/Home/presentation/widgets/CustomappBar.dart';
import 'package:mobile/features/Home/presentation/widgets/sideBar.dart';
import 'package:mobile/features/group_display/presentation/pages/students_table.dart';
import 'package:mobile/features/group_display/presentation/widgets/circular_profile_image.dart';
import 'package:mobile/features/group_display/presentation/widgets/stats_display_widget.dart';
import 'package:mobile/features/group_display/presentation/widgets/user_stats_radar_widget.dart';

class GroupDetails extends StatefulWidget {
  const GroupDetails({super.key});

  @override
  State<GroupDetails> createState() => _GroupDetailsState();
}

class _GroupDetailsState extends State<GroupDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // Create a sidebar controller
  final SidebarController _sidebarController = SidebarController();
  int _selectedIndex = 6;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      key: _scaffoldKey,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Customappbar(
            onMenuPressed: () {
              _sidebarController.toggleSidebar();
            },
          )),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AASTU Group 57',
                        style: GoogleFonts.publicSans(
                          textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: theme.colorScheme.onBackground),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Groups',
                            style: GoogleFonts.publicSans(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: theme.colorScheme.onBackground),
                            ),
                          ),
                          Text(
                            ' • G57',
                            style: GoogleFonts.publicSans(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: theme.colorScheme.onBackground
                                      .withOpacity(0.6)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                StatsDisplayWidget(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.s,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Heads',
                          style: GoogleFonts.publicSans(
                            textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: theme.colorScheme.onBackground),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            CircularProfileImage(
                              imageUrl:
                                  'https://storage.googleapis.com/a2sv_hub_bucket_2/%2Fimages%2FWubshet%20Zeleke_g33.jpg',
                              radius: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CircularProfileImage(
                              imageUrl:
                                  'https://storage.googleapis.com/a2sv_hub_bucket_2/%2Fimages%2FYidnekachew%20Tebeje_g46.jpg',
                              radius: 20,
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Text(
                          'Titles',
                          style: GoogleFonts.publicSans(
                            textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: theme.colorScheme.onBackground),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            CircularProfileImage(
                              imageUrl:
                                  'https://hub.a2sv.org/illustrations/titles/coder.png',
                              radius: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CircularProfileImage(
                              imageUrl:
                                  'https://hub.a2sv.org/illustrations/titles/strategist.png',
                              radius: 20,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    child: DiamondRatingChart(
                      performance: 89.5, // Based on your image
                      experience: 71.7, // Based on your image
                      consistency: 60.4, // Based on your image
                      fourthMetric: 55.7, // Based on your image
                      // titleIcons: titleIcons,
                      labels: [
                        'Attendance',
                        'Completion',
                        'Consistency',
                        'Progress'
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FutureBuilder<List<Student>>(
                  future: fetchStudents(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No students found'));
                    }

                    final students = snapshot.data!;
                    return StudentDataTable(students: students);
                  },
                ),
              ],
            ),
          ),
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
        ],
      ),
    );
  }
}

// Example Data - Replace with your actual data
const String exampleProfilePic =
    'https://storage.googleapis.com/a2sv_hub_bucket_2/images%2FNatnael%20Wondwoesn%20Solomon.jpeg'; // Placeholder asset path
final List<String> exampleTitles = [
  'https://storage.googleapis.com/a2sv_hub_bucket_2/images%2FNatnael%20Wondwoesn%20Solomon.jpeg', // Placeholder asset paths
  'https://storage.googleapis.com/a2sv_hub_bucket_2/images%2FNatnael%20Wondwoesn%20Solomon.jpeg',
  'https://storage.googleapis.com/a2sv_hub_bucket_2/images%2FNatnael%20Wondwoesn%20Solomon.jpeg',
];
final List<String> exampleLabels = [
  'Problem Solving',
  'Consistency',
  'Speed',
  'Communication',
  'Teamwork',
  'Leadership',
];
final List<double> exampleData = [
  85.0,
  70.0,
  65.0,
  90.0,
  75.0,
  80.0,
];

// Create circular icons for the title row
final titleIcons = [
  CircleAvatar(backgroundColor: Colors.grey[300], radius: 12),
  CircleAvatar(backgroundColor: Colors.brown[500], radius: 12),
  CircleAvatar(backgroundColor: Colors.grey[500], radius: 12),
  CircleAvatar(backgroundColor: Colors.grey[700], radius: 12),
  CircleAvatar(backgroundColor: Colors.grey[900], radius: 12),
  Container(
    alignment: Alignment.center,
    width: 40,
    height: 24,
    decoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      '89.5',
      style: TextStyle(
          color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
    ),
  ),
];

Future<List<Student>> parseJsonData(String jsonString) async {
  try {
    // Remove the leading "students": [ and trailing ], part if needed
    String processedJson = jsonString;
    if (jsonString.trim().startsWith('"students":')) {
      processedJson = '{$jsonString}';
    }

    // Parse the JSON
    final Map<String, dynamic> parsed = {
      "students": [
        {
          "id": 638,
          "name": "Aduna Kebeda Hunde",
          "photo":
              "https://storage.googleapis.com/a2sv_hub_bucket_2/%2Fimages%2FAduna%20Kebeda%20Hunde_G57.jpg",
          "group_id": 30,
          "meta": {
            "solvedProblems_count": "354",
            "time_spent": "8080",
            "rating": 1240
          },
          "title": {
            "title": "solver",
            "div": 1,
            "next": {"title": "strategist", "div": 3}
          },
          "last_seen": {"raw": "2025-04-08T14:51:28.701Z", "spice": " 19d  44m"}
        },
        {
          "id": 660,
          "name": "Tarikua Misganaw Diriba",
          "photo":
              "https://storage.googleapis.com/a2sv_hub_bucket_2/%2Fimages%2FTarikua%20Misganaw%20Diriba_G57.jpg",
          "group_id": 30,
          "meta": {
            "solvedProblems_count": "336",
            "time_spent": "12691",
            "rating": 929
          },
          "title": {
            "title": "coder",
            "div": 1,
            "next": {"title": "solver", "div": 3}
          },
          "last_seen": {
            "raw": "2025-01-18T20:20:02.538Z",
            "spice": " 98d  19h 15m"
          }
        },
        {
          "id": 650,
          "name": "Hiwot Belay Kebede",
          "photo":
              "https://storage.googleapis.com/a2sv_hub_bucket_2/images%2FHiwot%20Belay%20Kebede.jpg",
          "group_id": 30,
          "meta": {
            "solvedProblems_count": "453",
            "time_spent": "16580",
            "rating": 1287
          },
          "title": {
            "title": "solver",
            "div": 1,
            "next": {"title": "strategist", "div": 3}
          },
          "last_seen": {
            "raw": "2025-02-13T20:41:23.967Z",
            "spice": " 72d  18h 54m"
          }
        },
        {
          "id": 654,
          "name": "Mihret Desalegn Woldemariam",
          "photo":
              "https://storage.googleapis.com/a2sv_hub_bucket_2/%2Fimages%2FMihret%20Desalegn%20Woldemariam_G57.jpg",
          "group_id": 30,
          "meta": {
            "solvedProblems_count": "420",
            "time_spent": "8069",
            "rating": 1519
          },
          "title": {
            "title": "strategist",
            "div": 1,
            "next": {"title": "knight", "div": 3}
          },
          "last_seen": {
            "raw": "2025-02-06T10:03:33.233Z",
            "spice": " 80d  5h 32m"
          }
        },
        {
          "id": 656,
          "name": "Naod Mulugeta Teraga",
          "photo":
              "https://storage.googleapis.com/a2sv_hub_bucket_2/%2Fimages%2FNaod%20Mulugeta%20Teraga_G57.jpg",
          "group_id": 30,
          "meta": {
            "solvedProblems_count": "450",
            "time_spent": "11872",
            "rating": 1602
          },
          "title": {
            "title": "knight",
            "div": 3,
            "next": {"title": "knight", "div": 2}
          },
          "last_seen": {
            "raw": "2025-01-22T08:58:08.345Z",
            "spice": " 95d  6h 37m"
          }
        },
        {
          "id": 648,
          "name": "Feven Alemayehu Haile",
          "photo":
              "https://storage.googleapis.com/a2sv_hub_bucket_2/%2Fimages%2FFeven%20Alemayehu%20Haile_G57.jpg",
          "group_id": 30,
          "meta": {
            "solvedProblems_count": "303",
            "time_spent": "10701",
            "rating": 1147
          },
          "title": {
            "title": "solver",
            "div": 2,
            "next": {"title": "solver", "div": 1}
          },
          "last_seen": {
            "raw": "2024-08-01T17:40:51.680Z",
            "spice": " 268d  21h 54m"
          }
        },
        {
          "id": 661,
          "name": "Yetnayet Lakew Aramde",
          "photo":
              "https://storage.googleapis.com/a2sv_hub_bucket_2/%2Fimages%2FYetnayet%20Lakew%20Aramde_G57.jpg",
          "group_id": 30,
          "meta": {
            "solvedProblems_count": "535",
            "time_spent": "14075",
            "rating": 1332
          },
          "title": {
            "title": "strategist",
            "div": 3,
            "next": {"title": "strategist", "div": 2}
          },
          "last_seen": {
            "raw": "2025-04-26T09:26:03.152Z",
            "spice": " 1d  6h 9m"
          }
        },
        {
          "id": 644,
          "name": "Estifanos Zinabu Abebe",
          "photo":
              "https://storage.googleapis.com/a2sv_hub_bucket_2/%2Fimages%2FEstifanos%20Zinabu%20Abebe_G57.jpg",
          "group_id": 30,
          "meta": {
            "solvedProblems_count": "393",
            "time_spent": "8844",
            "rating": 1223
          },
          "title": {
            "title": "solver",
            "div": 1,
            "next": {"title": "strategist", "div": 3}
          },
          "last_seen": {
            "raw": "2025-04-15T16:01:30.791Z",
            "spice": " 11d  23h 34m"
          }
        },
        {
          "id": 649,
          "name": "Hawi Abdi Nagaasa",
          "photo":
              "https://storage.googleapis.com/a2sv_hub_bucket_2/images%2FHawi%20Abdi%20Nagaasa.jpg",
          "group_id": 30,
          "meta": {
            "solvedProblems_count": "384",
            "time_spent": "10754",
            "rating": 830
          },
          "title": {
            "title": "coder",
            "div": 2,
            "next": {"title": "coder", "div": 1}
          },
          "last_seen": {"raw": "2025-04-08T15:12:15.402Z", "spice": " 19d  23m"}
        },
        {
          "id": 645,
          "name": "Eyob Mamo Abiye",
          "photo":
              "https://storage.googleapis.com/a2sv_hub_bucket_2/%2Fimages%2FEyob%20Mamo%20Abiye_G57.jpg",
          "group_id": 30,
          "meta": {
            "solvedProblems_count": "257",
            "time_spent": "9373",
            "rating": 1159
          },
          "title": {
            "title": "solver",
            "div": 2,
            "next": {"title": "solver", "div": 1}
          },
          "last_seen": {
            "raw": "2025-03-05T20:11:40.868Z",
            "spice": " 52d  19h 24m"
          }
        },
        // Add more students as needed from the JSON
      ]
    };

    return (parsed['students'] as List)
        .map((studentJson) => Student.fromJson(studentJson))
        .toList();
  } catch (e) {
    throw Exception('Failed to parse JSON: $e');
  }
}

Future<List<Student>> fetchStudents() async {
  try {
    // Replace this with your actual data fetching logic
    final jsonString = ''; // Define your JSON string or fetch it from a source
    return await parseJsonData(jsonString);
  } catch (e) {
    throw Exception('Failed to fetch students: $e');
  }
}
