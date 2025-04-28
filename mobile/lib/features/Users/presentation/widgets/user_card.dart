import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class UserCard extends StatelessWidget {
  final Map<String, dynamic> userData;

  const UserCard({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Extract data safely, providing defaults
    final String name = userData['name'] ?? 'Unknown Name';
    final String role =
        (userData['role'] as Map?)?['type'] as String? ?? 'Unknown Role';
    final String group =
        (userData['group'] as Map?)?['short_name'] as String? ?? 'N/A';
    final String avatarUrl = userData['photo'] ?? '';
    final String backgroundImageUrl = ''; // Not available in provided JSON
    final int problemsCount = int.tryParse(
            (userData['meta'] as Map?)?['solvedProblems_count'] as String? ??
                '0') ??
        0;
    final int submissionsCount = int.tryParse(
            (userData['meta'] as Map?)?['submissions_count'] as String? ??
                '0') ??
        0;
    // Handle potentially null time_spent
    final dynamic timeSpentRaw = (userData['meta'] as Map?)?['time_spent'];
    final int dedicatedTime = timeSpentRaw is String
        ? (int.tryParse(timeSpentRaw) ?? 0)
        : (timeSpentRaw is int ? timeSpentRaw : 0);

    // Placeholder avatar if URL is empty
    Widget avatar = avatarUrl.isNotEmpty
        ? CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(avatarUrl),
          )
        : const CircleAvatar(
            radius: 35,
            backgroundColor: Colors.grey, // Placeholder color
            child: Icon(Icons.person, size: 35, color: Colors.white),
          );

    // Placeholder background
    Widget background = avatarUrl.isNotEmpty
        ? Stack(
            children: [
              Image.network(
                avatarUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                child: Container(
                  height: 200,
                  width: double.infinity,
                  color: Color.fromRGBO(0, 82, 73, 0.7), // Placeholder color
                ),
              ),
            ],
          )
        : Container(
            height: 120,
            width: double.infinity,
            color: Colors.teal[400], // Placeholder color
          );

    return Card(
      color: Colors.white,
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      clipBehavior: Clip.antiAlias, // Clip content to card shape
      margin: const EdgeInsets.all(8.0),
      child: Stack(
        // Use Stack for the filter icon overlay
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                clipBehavior: Clip.none, // Allow avatar to overflow
                alignment: Alignment.bottomCenter,
                children: [
                  background,
                  Positioned(
                    bottom: -35, // Half of avatar radius to overlap
                    child: avatar,
                  ),
                ],
              ),
              const SizedBox(
                  height: 45), // Space for overlapping avatar + padding
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Text(name,
                        style: GoogleFonts.publicSans(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16))),
                    const SizedBox(height: 4),
                    Text(
                      '$role • $group',
                      style: GoogleFonts.publicSans(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color.fromRGBO(99, 115, 129, 1))),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // TODO: Replace with actual icons from image
                        SvgPicture.asset(
                          'assets/svgs/leetcode.svg',
                          color: Color.fromRGBO(252, 144, 3, 1),
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 10),
                        SvgPicture.asset(
                          'assets/svgs/cf.svg',
                          color: Colors.blue,
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 10),
                        SvgPicture.asset(
                          'assets/svgs/hackerrank.svg',
                          color: Color.fromRGBO(0, 150, 25, 1),
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 10),
                        SvgPicture.asset(
                          'assets/svgs/tg.svg',
                          // color: Colors.lightBlue,
                          width: 20,
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                  height: 32.0,
                  thickness: 0.5,
                  indent: 16,
                  endIndent: 16,
                  color: Color.fromRGBO(33, 43, 54, 0.1)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatColumn(
                        'Problems', problemsCount.toString(), textTheme),
                    _buildStatColumn(
                        'Submissions', submissionsCount.toString(), textTheme),
                    _buildStatColumn(
                        'Dedicated Time', dedicatedTime.toString(), textTheme),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // TODO: Implement view profile action
                },
                child: Text(
                  'View Profile',
                  style: TextStyle(
                      color: const Color.fromRGBO(
                          0, 171, 85, 1), // Match header color
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8), // Padding at the bottom
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value, TextTheme textTheme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: GoogleFonts.publicSans(
              textStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color.fromRGBO(145, 158, 171, 1))),
        ),
        const SizedBox(height: 4),
        Text(
          int.tryParse(value) != null && int.parse(value) >= 1000
              ? '${(int.parse(value) / 1000).toStringAsFixed(1)}k'
              : value,
          style: GoogleFonts.publicSans(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color.fromRGBO(33, 43, 54, 1))),
        ),
      ],
    );
  }
}
