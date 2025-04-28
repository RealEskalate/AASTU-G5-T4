import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/features/Home/presentation/widgets/CustomappBar.dart';
import 'package:mobile/features/Home/presentation/widgets/sideBar.dart';
import 'package:mobile/features/group_display/presentation/widgets/group_card_widget.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // Create a sidebar controller
  final SidebarController _sidebarController = SidebarController();
  int _selectedIndex = 6;

  @override
  void dispose() {
    _sidebarController.dispose();
    super.dispose();
  }

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
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Groups',
                        style: GoogleFonts.publicSans(
                          textStyle: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: theme.colorScheme.onBackground),
                        ),
                      ),
                      Text(
                        'All',
                        style: GoogleFonts.publicSans(
                          textStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: theme.colorScheme.onBackground
                                  .withOpacity(0.6)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  ListView.builder(
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
                  )
                ],
              ),
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
];
