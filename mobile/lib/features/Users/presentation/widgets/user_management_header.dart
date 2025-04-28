import 'dart:convert'; // Import dart:convert
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/group_display/presentation/widgets/group_card_widget.dart';

// Import the UserCard widget
import 'user_card.dart';
// Import the UserDataTable widget
import 'user_data_table.dart';

class UserManagementHeader extends StatefulWidget {
  const UserManagementHeader({super.key});

  @override
  State<UserManagementHeader> createState() => _UserManagementHeaderState();
}

class _UserManagementHeaderState extends State<UserManagementHeader>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<bool> _isSelected = [true, false]; // For ToggleButtons
  int _currentTabIndex = 0; // Add state for current tab index
  List<Map<String, dynamic>> _usersData =
      []; // State variable for parsed user data

  // Define listener method
  void _handleTabSelection() {
    // Check if the controller's index has actually changed
    if (_tabController.index != _currentTabIndex) {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Add the defined method as the listener
    _tabController.addListener(_handleTabSelection);

    // Parse the JSON data
    _parseUsersData();
  }

  void _parseUsersData() {
    // The JSON data provided by the user (only 5 users)
    const String jsonString = '''
    [
        {
            "id": 609,
            "role_id": 1,
            "name": "Adane Moges Erdachew",
            "country_id": 69,
            "university": "Addis Ababa Science and Technology University (AASTU)",
            "email": "adane.moges@a2sv.org",
            "leetcode": "https://leetcode.com/adanemoges6",
            "codeforces": "https://codeforces.com/profile/Habeshaethiopia",
            "github": "https://github.com/habeshaethiopia",
            "photo": "https://storage.googleapis.com/a2sv_hub_bucket_2/images%2FAdane%20Moges%20Erdachew.jpg",
            "preferred_language": "Python",
            "hackerrank": "https://www.hackerrank.com/adanemoges6",
            "group_id": 29,
            "phone": "+251 98 376 3133",
            "telegram_username": "adman1994",
            "telegram_uid": null,
            "linkedin": "https://www.linkedin.com/in/adane-moges/",
            "student_id": "Ets0079/13",
            "short_bio": "Hello, I'm Adane, a fourth-year software engineering student at AASTU. I have a keen interest in problem-solving and continuous learning. I find great fulfillment in understanding the details of how things operate. Applying my knowledge and skills to real-world scenarios is where I excel, as it allows me to make a meaningful impact and witness the results of my efforts firsthand. ",
            "instagram": null,
            "birthday": "2002-04-13T00:00:00.000+00:00",
            "cv": null,
            "joined_date": null,
            "expected_graduation_date": null,
            "mentor_name": null,
            "tshirt_color": null,
            "tshirt_size": null,
            "gender": "MALE",
            "code_of_conduct": null,
            "created_at": "2024-03-13T14:01:26.861+00:00",
            "updated_at": "2024-05-06T11:17:49.546+00:00",
            "config": {
                "leetcode_sync": true,
                "consistency_tracker": true,
                "github_enabled": true,
                "github_username": "habeshaethiopia",
                "github_repo": "comptetive-programing",
                "github_personal_token": "[REDACTED]"
            },
            "department": "Software",
            "inactive": false,
            "group": {
                "name": "AASTU Group 56",
                "short_name": "G56",
                "id": 29,
                "meta": {}
            },
            "role": {
                "type": "Student",
                "id": 1,
                "meta": {}
            },
            "country": {
                "name": "Ethiopia",
                "id": 69,
                "meta": {}
            },
            "meta": {
                "solvedProblems_count": "433",
                "submissions_count": "492",
                "time_spent": "11901"
            }
        },
        {
            "id": 1283,
            "role_id": 1,
            "name": "ISHMAEL AFFUM KWAKYE",
            "country_id": 87,
            "university": "University of Ghana",
            "email": "ishmael.kwakye@a2sv.org",
            "leetcode": "https://leetcode.com/calyxish",
            "codeforces": "https://codeforces.com/profile/worldconquerer",
            "github": "https://github.com/calyxish",
            "photo": "https://storage.googleapis.com/a2sv_hub_bucket_2/images%2FISHMAEL%20AFFUM%20KWAKYE.png",
            "preferred_language": "Python",
            "hackerrank": "https://www.hackerrank.com/profile/calyxish",
            "group_id": null,
            "phone": "+233 54 975 3746",
            "telegram_username": "@calyxish",
            "telegram_uid": null,
            "linkedin": null,
            "student_id": null,
            "short_bio": "Resilience | Relentless | Restless",
            "instagram": "@calyxish",
            "birthday": "2005-07-25T00:00:00.000+00:00",
            "cv": null,
            "joined_date": "2024-01-15T00:00:00.000+00:00",
            "expected_graduation_date": "2027-10-30T00:00:00.000+00:00",
            "mentor_name": null,
            "tshirt_color": "Navy Blue",
            "tshirt_size": "M",
            "gender": "MALE",
            "code_of_conduct": null,
            "created_at": "2025-02-22T14:33:05.202+00:00",
            "updated_at": "2025-04-04T10:19:15.864+00:00",
            "config": null,
            "department": "Computer Science With Mathematics",
            "inactive": true,
            "group": null,
            "role": {
                "type": "Student",
                "id": 1,
                "meta": {}
            },
            "country": {
                "name": "Ghana",
                "id": 87,
                "meta": {}
            },
            "meta": {
                "solvedProblems_count": "0",
                "submissions_count": "0",
                "time_spent": null
            }
        },
        {
            "id": 933,
            "role_id": 1,
            "name": "Abiy Shiferaw",
            "country_id": 69,
            "university": "Bahir Dar University",
            "email": "abiy.chernet@a2sv.org",
            "leetcode": "https://leetcode.com/ABKodes/",
            "codeforces": "https://codeforces.com/profile/thevillainpro",
            "github": "https://github.com/abkodes",
            "photo": "https://storage.googleapis.com/a2sv_hub_bucket_2/images%2FAbiy%20Shiferaw.jpg",
            "preferred_language": "Python",
            "hackerrank": "https://www.hackerrank.com/profile/ABKodes",
            "group_id": 49,
            "phone": "+251 97 391 8873",
            "telegram_username": "https://t.me/ABKodes",
            "telegram_uid": null,
            "linkedin": null,
            "student_id": null,
            "short_bio": null,
            "instagram": null,
            "birthday": null,
            "cv": null,
            "joined_date": null,
            "expected_graduation_date": null,
            "mentor_name": null,
            "tshirt_color": null,
            "tshirt_size": null,
            "gender": "MALE",
            "code_of_conduct": null,
            "created_at": "2025-01-29T17:32:16.228+00:00",
            "updated_at": "2025-01-29T17:32:16.228+00:00",
            "config": null,
            "department": null,
            "inactive": false,
            "group": {
                "name": "Remote Group 6E",
                "short_name": "G6E",
                "id": 49,
                "meta": {}
            },
            "role": {
                "type": "Student",
                "id": 1,
                "meta": {}
            },
            "country": {
                "name": "Ethiopia",
                "id": 69,
                "meta": {}
            },
            "meta": {
                "solvedProblems_count": "192",
                "submissions_count": "204",
                "time_spent": "3647"
            }
        },
        {
            "id": 277,
            "role_id": 1,
            "name": "Abel Getahun",
            "country_id": 69,
            "university": "AASTU",
            "email": "abelgetahun55@gmail.com",
            "leetcode": "https://leetcode.com/abelops/",
            "codeforces": "https://codeforces.com/profile/abelops",
            "github": "https://github.com/abelops",
            "photo": "https://storage.googleapis.com/a2sv_hub_bucket_2/%2Fimages%2FAbel%20Getahun_g46.jpg",
            "preferred_language": "Python",
            "hackerrank": "https://www.hackerrank.com/abelgetahun55",
            "group_id": 9,
            "phone": null,
            "telegram_username": "abelgetahun",
            "telegram_uid": null,
            "linkedin": null,
            "student_id": null,
            "short_bio": "Aspiring a software engineer with a deep interest in solving problems using programming. Continuously striving to expand my skills and knowledge, I am driven by a desire to apply these abilities to address real-world challenges. My ultimate goal is to utilize my expertise to develop innovative solutions that make a meaningful impact on society.",
            "instagram": null,
            "birthday": null,
            "cv": null,
            "joined_date": null,
            "expected_graduation_date": null,
            "mentor_name": "Dawit Getachew",
            "tshirt_color": "Blue Black",
            "tshirt_size": "XL",
            "gender": null,
            "code_of_conduct": null,
            "created_at": "2023-12-16T19:09:17.113+00:00",
            "updated_at": "2023-12-16T19:09:17.113+00:00",
            "config": null,
            "department": null,
            "inactive": false,
            "group": {
                "name": "A2SV AASTU Group 46",
                "short_name": "G46",
                "id": 9,
                "meta": {}
            },
            "role": {
                "type": "Student",
                "id": 1,
                "meta": {}
            },
            "country": {
                "name": "Ethiopia",
                "id": 69,
                "meta": {}
            },
            "meta": {
                "solvedProblems_count": "164",
                "submissions_count": "164",
                "time_spent": "5654"
            }
        },
               {
            "id": 918,
            "role_id": 1,
            "name": "Abdulhamid Hayredin",
            "country_id": 69,
            "university": "Hawassa University",
            "email": "abdulhamid.suleyman@a2sv.org",
            "leetcode": "https://leetcode.com/ibnu-asma/",
            "codeforces": "https://codeforces.com/profile/ibnu-asma",
            "github": "https://github.com/ibnu-asma",
            "photo": "https://storage.googleapis.com/a2sv_hub_bucket_2/images%2FAbdulhamid%20Hayredin.JPG",
            "preferred_language": "Python",
            "hackerrank": "https://www.hackerrank.com/profile/abdulhamidhayre1",
            "group_id": 54,
            "phone": "+251 91 164 8816",
            "telegram_username": "@abdu_0123",
            "telegram_uid": null,
            "linkedin": "https://www.linkedin.com/in/ibnu-asma-30a1a2221",
            "student_id": null,
            "short_bio": "Ethical hacker",
            "instagram": null,
            "birthday": "2001-07-18T00:00:00.000+00:00",
            "cv": null,
            "joined_date": null,
            "expected_graduation_date": null,
            "mentor_name": null,
            "tshirt_color": "Black",
            "tshirt_size": "L",
            "gender": "MALE",
            "code_of_conduct": null,
            "created_at": "2025-01-29T11:15:26.210+00:00",
            "updated_at": "2025-04-05T05:34:24.013+00:00",
            "config": {
                "leetcode_sync": false,
                "consistency_tracker": false,
                "github_enabled": true,
                "github_username": "ibnu-asma",
                "github_repo": "A2SV-competitive_programming",
                "github_personal_token": "[REDACTED]WCzDVIfCRRYWX7EoBEcjNuD3xDnq2nauMfknjf8IFBFCyNjg3AVX7rE3hyLewLzAeCREKUcBaHYIJ1ETkFh_1A.aVRCLU5RbVRhamhsaE9uRw.Mfi0vUXICt4jKF0ayrFtaVYBH2Zt9WppbItJ2EB56Dw"
            },
            "department": null,
            "inactive": false,
            "group": {
                "name": "Remote Group 6J",
                "short_name": "G6J",
                "id": 54,
                "meta": {}
            },
            "role": {
                "type": "Student",
                "id": 1,
                "meta": {}
            },
            "country": {
                "name": "Ethiopia",
                "id": 69,
                "meta": {}
            },
            "meta": {
                "solvedProblems_count": "235",
                "submissions_count": "255",
                "time_spent": "3242"
            }
        }
    ]
    ''';
    // Use try-catch for robustness
    try {
      final List<dynamic> parsedJson = jsonDecode(jsonString);
      // Ensure the parsed data is a list of maps
      _usersData = List<Map<String, dynamic>>.from(
          parsedJson.where((item) => item is Map<String, dynamic>));
    } catch (e) {
      print("Error parsing user JSON data: $e");
      _usersData = []; // Set to empty list on error
    }
  }

  @override
  void dispose() {
    // Remove the specific listener method
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    // final colorScheme = theme.colorScheme;

    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: const Color.fromRGBO(0, 171, 85, 1), // Active tab color
          unselectedLabelColor: Colors.grey, // Inactive tab color
          indicatorColor:
              const Color.fromRGBO(0, 171, 85, 1), // Underline color
          indicatorWeight: 3.0,
          tabs: const [
            Tab(text: 'Users'),
            Tab(text: 'Groups'),
            Tab(text: 'Countries'),
          ],
        ),
        // Conditionally display Grid or List view
        if (_currentTabIndex == 0)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                const SizedBox(height: 16.0), // Space between tabs and content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    height: 40.0, // Match the previous ToggleButtons height
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (!_isSelected[0]) {
                                setState(() {
                                  _isSelected[0] = true;
                                  _isSelected[1] = false;
                                  // TODO: Implement view change logic
                                });
                              }
                            },
                            child: Container(
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                color: _isSelected[0]
                                    ? const Color.fromRGBO(0, 171, 85, 1)
                                        .withOpacity(0.1) // Selected background
                                    : Colors
                                        .transparent, // Unselected background
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(
                                      7.0), // Adjust to inner radius
                                  bottomLeft: Radius.circular(7.0),
                                ),
                              ),
                              child: Icon(
                                size: 20.0,
                                Icons.grid_view_rounded,
                                color: _isSelected[0]
                                    ? const Color.fromRGBO(
                                        0, 171, 85, 1) // Selected icon color
                                    : Colors.grey[600], // Unselected icon color
                              ),
                            ),
                          ),
                        ),
                        // Divider line if needed
                        // VerticalDivider(width: 1, thickness: 1, color: Colors.grey[300]),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (!_isSelected[1]) {
                                setState(() {
                                  _isSelected[0] = false;
                                  _isSelected[1] = true;
                                  // TODO: Implement view change logic
                                });
                              }
                            },
                            child: Container(
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                color: _isSelected[1]
                                    ? const Color.fromRGBO(0, 171, 85, 1)
                                        .withOpacity(0.1) // Selected background
                                    : Colors
                                        .transparent, // Unselected background
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(
                                      7.0), // Adjust to inner radius
                                  bottomRight: Radius.circular(7.0),
                                ),
                              ),
                              child: Icon(
                                Icons.list_rounded,
                                color: _isSelected[1]
                                    ? const Color.fromRGBO(
                                        0, 171, 85, 1) // Selected icon color
                                    : Colors.grey[600], // Unselected icon color
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search user...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                              color: const Color.fromRGBO(0, 171, 85, 1)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 16.0) // Adjust padding
                        ),
                    onChanged: (value) {
                      // TODO: Implement search logic
                    },
                  ),
                ),
                const SizedBox(
                    height: 16.0), // Space between search and content

                // Conditionally display Grid or List view within an Expanded
                Expanded(
                  child: _isSelected[0]
                      ? ListView.builder(
                          itemCount: _usersData.length,
                          shrinkWrap: true,
                          physics:
                              const AlwaysScrollableScrollPhysics(), // Make it scrollable
                          itemBuilder: (context, index) {
                            return UserCard(userData: _usersData[index]);
                          },
                        )
                      : UserDataTable(
                          usersData:
                              _usersData), // Table is already wrapped in Expanded internally
                ),
              ],
            ),
          ),
        if (_currentTabIndex == 1)
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.99,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    final group = groups[index];
                    return GestureDetector(
                      onTap: () => context.go('/group_details'),
                      child: GroupCardWidget(
                        groupName: group['groupName'],
                        groupAbbreviation: group['groupAbbreviation'],
                        memberCount: group['memberCount'],
                        timeSpent: group['timeSpent'],
                        avgRating: group['avgRating'].toString(),
                      ),
                    );
                  },
                )),
          ),
      ],
    );
  }
}

List<dynamic> groups = [
  {
    'groupName': 'AASTU Group 57',
    'groupAbbreviation': 'G57',
    'memberCount': 25,
    'timeSpent': '256,744 hours',
    'avgRating': 1282,
  },
  {
    'groupName': 'Group 6 Remote Ramadan Group',
    'groupAbbreviation': 'G6R',
    'memberCount': 0,
    'timeSpent': '0 Hours',
    'avgRating': 0,
  },
  {
    'groupName': 'Ghana Group 60',
    'groupAbbreviation': 'G60',
    'memberCount': 37,
    'timeSpent': '74,569 hours',
    'avgRating': 1413,
  },
  {
    'groupName': 'AASTU Group 57',
    'groupAbbreviation': 'G57',
    'memberCount': 25,
    'timeSpent': '256,744 hours',
    'avgRating': 1282,
  },
  {
    'groupName': 'AASTU Group 57',
    'groupAbbreviation': 'G57',
    'memberCount': 25,
    'timeSpent': '256,744 hours',
    'avgRating': 1282,
  },
  {
    'groupName': 'AASTU Group 57',
    'groupAbbreviation': 'G57',
    'memberCount': 25,
    'timeSpent': '256,744 hours',
    'avgRating': 1282,
  },
  {
    'groupName': 'AASTU Group 57',
    'groupAbbreviation': 'G57',
    'memberCount': 25,
    'timeSpent': '256,744 hours',
    'avgRating': 1282,
  },
  {
    'groupName': 'AASTU Group 57',
    'groupAbbreviation': 'G57',
    'memberCount': 25,
    'timeSpent': '256,744 hours',
    'avgRating': 1282,
  },
  {
    'groupName': 'AASTU Group 57',
    'groupAbbreviation': 'G57',
    'memberCount': 25,
    'timeSpent': '256,744 hours',
    'avgRating': 1282,
  },
  {
    'groupName': 'AASTU Group 57',
    'groupAbbreviation': 'G57',
    'memberCount': 25,
    'timeSpent': '256,744 hours',
    'avgRating': 1282,
  },
  {
    'groupName': 'AASTU Group 57',
    'groupAbbreviation': 'G57',
    'memberCount': 25,
    'timeSpent': '256,744 hours',
    'avgRating': 1282,
  },
  {
    'groupName': 'AASTU Group 57',
    'groupAbbreviation': 'G57',
    'memberCount': 25,
    'timeSpent': '256,744 hours',
    'avgRating': 1282,
  },
  {
    'groupName': 'AASTU Group 57',
    'groupAbbreviation': 'G57',
    'memberCount': 25,
    'timeSpent': '256,744 hours',
    'avgRating': 1282,
  },
  {
    'groupName': 'AASTU Group 57',
    'groupAbbreviation': 'G57',
    'memberCount': 25,
    'timeSpent': '256,744 hours',
    'avgRating': 1282,
  },
  {
    'groupName': 'AASTU Group 57',
    'groupAbbreviation': 'G57',
    'memberCount': 25,
    'timeSpent': '256,744 hours',
    'avgRating': 1282,
  },
  {
    'groupName': 'AASTU Group 57',
    'groupAbbreviation': 'G57',
    'memberCount': 25,
    'timeSpent': '256,744 hours',
    'avgRating': 1282,
  },
  {
    'groupName': 'AASTU Group 57',
    'groupAbbreviation': 'G57',
    'memberCount': 25,
    'timeSpent': '256,744 hours',
    'avgRating': 1282,
  },
  {
    'groupName': 'AASTU Group 57',
    'groupAbbreviation': 'G57',
    'memberCount': 25,
    'timeSpent': '256,744 hours',
    'avgRating': 1282,
  },
  {
    'groupName': 'AASTU Group 57',
    'groupAbbreviation': 'G57',
    'memberCount': 25,
    'timeSpent': '256,744 hours',
    'avgRating': 1282,
  },
];
