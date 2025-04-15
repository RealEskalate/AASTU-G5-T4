import 'package:flutter/material.dart';
import 'package:mobile/features/Profile/presentation/widgets/consistency_calendar.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  // Sample list of tabs with expanded TabData class
  final List<TabData> _tabs = [
    TabData(
      icon: Icons.person,
      label: 'Profile',
      badge: null,
      content: const ProfileTabContent(),
    ),
    TabData(
      icon: Icons.code,
      label: 'Problems',
      badge: const Badge(count: 5, color: Colors.red),
      content: const ProblemsTabContent(),
    ),
    TabData(
      icon: Icons.assignment,
      label: 'Assignments',
      badge: const Badge(count: 2, color: Colors.orange),
      content: const AssignmentsTabContent(),
    ),
    TabData(
      icon: Icons.leaderboard,
      label: 'Leaderboard',
      content: const LeaderboardTabContent(),
    ),
    TabData(
      icon: Icons.history,
      label: 'History',
      content: const HistoryTabContent(),
    ),
    TabData(
      icon: Icons.settings,
      label: 'Settings',
      content: const SettingsTabContent(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);

    // Listen to tab changes to scroll the TabBar accordingly
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _scrollToActiveTab();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Scroll to make the active tab visible
  void _scrollToActiveTab() {
    // Calculate approximate position of the tab
    final tabWidth =
        MediaQuery.of(context).size.width * 0.9 / 3; // Assuming 3 visible tabs
    final scrollOffset = (_tabController.index * tabWidth) - tabWidth;

    if (scrollOffset > 0 &&
        scrollOffset < _scrollController.position.maxScrollExtent) {
      _scrollController.animateTo(
        scrollOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Scroll one page of tabs to the right
  void _scrollRight() {
    final currentOffset = _scrollController.offset;
    final maxOffset = _scrollController.position.maxScrollExtent;
    final viewportWidth = _scrollController.position.viewportDimension;

    final targetOffset = (currentOffset + viewportWidth).clamp(0.0, maxOffset);

    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Scroll one page of tabs to the left
  void _scrollLeft() {
    final currentOffset = _scrollController.offset;
    final viewportWidth = _scrollController.position.viewportDimension;

    final targetOffset = (currentOffset - viewportWidth)
        .clamp(0.0, _scrollController.position.maxScrollExtent);

    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Gradient background with profile info
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.centerRight,
                colors: [
                  Color.fromRGBO(17, 94, 89, 1),
                  Color.fromRGBO(17, 94, 89, 0.7),
                ],
                stops: [0.0, 1.0],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                // Profile Picture
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 38,
                    backgroundImage: NetworkImage(
                      'https://storage.googleapis.com/a2sv_hub_bucket_2/images%2FNatnael%20Wondwoesn%20Solomon.jpeg',
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Name
                const Text(
                  'Natnael Wondwoesn Solomon',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),

                // Role and Online Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Student',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Online',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Left scroll button
                    IconButton(
                      icon: const Icon(Icons.chevron_left,
                          color: Color(0xFF1E6E5F)),
                      onPressed: _scrollLeft,
                      splashRadius: 20,
                    ),
                    // Scrollable tabs - FIXED: Removed scrollController parameter
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        child: TabBar(
                          controller: _tabController,
                          isScrollable: true,
                          indicatorColor: const Color(0xFF1E6E5F),
                          indicatorWeight: 3,
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelColor: Colors.black87,
                          unselectedLabelColor: Colors.grey,
                          tabs: _tabs
                              .map((tab) => Tab(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        tab.badgePosition ==
                                                    BadgePosition.left &&
                                                tab.badge != null
                                            ? BadgeIcon(
                                                icon: tab.icon,
                                                badge: tab.badge!)
                                            : Icon(tab.icon, size: 20),
                                        const SizedBox(width: 8),
                                        tab.badgePosition ==
                                                    BadgePosition.right &&
                                                tab.badge != null
                                            ? Row(
                                                children: [
                                                  Text(tab.label),
                                                  const SizedBox(width: 4),
                                                  tab.badge!,
                                                ],
                                              )
                                            : Text(tab.label),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),

                    // Right scroll button
                    IconButton(
                      icon: const Icon(Icons.chevron_right,
                          color: Color(0xFF1E6E5F)),
                      onPressed: _scrollRight,
                      splashRadius: 20,
                    ),
                  ],
                ),

                // Card(
                //   color: Colors.white,
                //   child: SizedBox(
                //     height: 170,
                //     width: MediaQuery.of(context).size.width * 0.9,
                //     child: TabBarView(
                //       controller: _tabController,
                //       children: _tabs.map((tab) => tab.content).toList(),
                //     ),
                //   ),
                // )
              ],
            ),
          ),

          // Scrollable tab bar with navigation buttons

          // Tab content
        ],
      ),
    );
  }
}

// Badge positions enum
enum BadgePosition { left, right }

// Badge widget for notifications
class Badge extends StatelessWidget {
  final int count;
  final Color color;
  final double size;
  final TextStyle? textStyle;

  const Badge({
    Key? key,
    required this.count,
    this.color = Colors.red,
    this.size = 16.0,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          count > 9 ? '9+' : count.toString(),
          style: textStyle ??
              TextStyle(
                color: Colors.white,
                fontSize: size * 0.6,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}

// Badge with icon widget
class BadgeIcon extends StatelessWidget {
  final IconData icon;
  final Badge badge;
  final double iconSize;

  const BadgeIcon({
    Key? key,
    required this.icon,
    required this.badge,
    this.iconSize = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon, size: iconSize),
        Positioned(
          top: -5,
          right: -5,
          child: badge,
        ),
      ],
    );
  }
}

// Enhanced TabData class with more features
class TabData {
  final IconData icon;
  final String label;
  final Badge? badge;
  final BadgePosition badgePosition;
  final Widget content;
  final bool isEnabled;
  final bool isClosable;
  final VoidCallback? onClose;

  TabData({
    required this.icon,
    required this.label,
    required this.content,
    this.badge,
    this.badgePosition = BadgePosition.left,
    this.isEnabled = true,
    this.isClosable = false,
    this.onClose,
  });

  // Create a copy of this TabData with some properties changed
  TabData copyWith({
    IconData? icon,
    String? label,
    Badge? badge,
    BadgePosition? badgePosition,
    Widget? content,
    bool? isEnabled,
    bool? isClosable,
    VoidCallback? onClose,
  }) {
    return TabData(
      icon: icon ?? this.icon,
      label: label ?? this.label,
      badge: badge ?? this.badge,
      badgePosition: badgePosition ?? this.badgePosition,
      content: content ?? this.content,
      isEnabled: isEnabled ?? this.isEnabled,
      isClosable: isClosable ?? this.isClosable,
      onClose: onClose ?? this.onClose,
    );
  }
}

// Example tab content widgets
class ProfileTabContent extends StatelessWidget {
  const ProfileTabContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Profile Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Email: natnael.solomon@example.com'),
          Text('Phone: +1234567890'),
          Text('Location: Addis Ababa, Ethiopia'),
        ],
      ),
    );
  }
}

class ProblemsTabContent extends StatelessWidget {
  const ProblemsTabContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent Problems',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('• Find Kth Bit In Nth Binary String'),
          Text('• Maximum Subarray Sum'),
          Text('• Valid Parentheses'),
        ],
      ),
    );
  }
}

class AssignmentsTabContent extends StatelessWidget {
  const AssignmentsTabContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Current Assignments',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('• Data Structures Project - Due in 3 days'),
          Text('• Algorithms Quiz - Due tomorrow'),
        ],
      ),
    );
  }
}

class LeaderboardTabContent extends StatelessWidget {
  const LeaderboardTabContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Leaderboard Content'));
  }
}

class HistoryTabContent extends StatelessWidget {
  const HistoryTabContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('History Content'));
  }
}

class SettingsTabContent extends StatelessWidget {
  const SettingsTabContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Settings Content'));
  }
}
