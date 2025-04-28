import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';

class HubSidebar extends StatelessWidget {
  final String username;
  final String userRole;
  final String userImageUrl;
  final int selectedIndex;
  final Function(int) onItemSelected;
  final VoidCallback onClose; // Added to handle closing the sidebar

  const HubSidebar({
    Key? key,
    required this.username,
    required this.userRole,
    required this.userImageUrl,
    this.selectedIndex = 0,
    required this.onItemSelected,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Dark blur overlay for the background
        Positioned.fill(
          child: GestureDetector(
            onTap: onClose, // Close sidebar when background is tapped
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
        ),

        // The sidebar itself
        Align(
          alignment: Alignment.centerLeft,
          child: SafeArea(
            child: Container(
              width: 280,
              height: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo section
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            // decoration: BoxDecoration(
                            //   color: const Color.fromRGBO(0, 171, 85, 1),
                            //   borderRadius: BorderRadius.circular(8),
                            // ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/svgs/vercel_logo.svg',
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(width: 8),
                        // const Text(
                        //   'HUB',
                        //   style: TextStyle(
                        //     fontSize: 24,
                        //     fontWeight: FontWeight.bold,
                        //     color: Color.fromRGBO(0, 171, 85, 1),
                        //   ),
                        // ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 0),

                  // User profile section
                  GestureDetector(
                    onTap: () {
                      context.go('/profile');
                      onClose(); // Close sidebar after navigation
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(userImageUrl),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  username,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  userRole,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // STUDENT label
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'STUDENT',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),

                  // Navigation menu in a scrollable container
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildMenuItem(context, 0, Icons.home_outlined,
                              'Home', false, '/home'),
                          _buildMenuItem(context, 1, Icons.apps, 'Tracks', true,
                              '/tracks'),
                          _buildMenuItem(context, 2, Icons.code_outlined,
                              'Problems', false, '/problems'),
                          _buildMenuItem(
                              context,
                              3,
                              Icons.emoji_events_outlined,
                              'Contests',
                              true,
                              '/contests'),
                          _buildMenuItem(context, 4, Icons.map_outlined,
                              'Roadmap', false, '/roadmap'),
                          _buildMenuItem(context, 5, Icons.person_outline,
                              'Users', false, '/users'),
                          _buildMenuItem(context, 6, Icons.people_outline,
                              'Groups', false, '/groups'),
                          _buildMenuItem(context, 7, Icons.forum_outlined,
                              'Forum', false, '/forum'),
                          _buildMenuItem(context, 8, Icons.school_outlined,
                              'Sessions', false, '/sessions'),
                        ],
                      ),
                    ),
                  ),

                  // Bottom content
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(0, 171, 85, 1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(
                            Icons.description_outlined,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(0, 171, 85, 1),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  '',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              '',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, int index, IconData icon,
      String title, bool hasSubmenu, String path) {
    final isSelected = index == selectedIndex;
    final backgroundColor = isSelected
        ? const Color(0xFFE9FFF4)
        : (index == 1 ? const Color(0xFFE9FFF4) : Colors.transparent);
    final textColor = isSelected || index == 1
        ? const Color.fromRGBO(0, 171, 85, 1)
        : Colors.black87;

    return Material(
      color: backgroundColor,
      child: InkWell(
        onTap: () {
          onItemSelected(index);
          context.go(path);
          onClose(); // Close sidebar after navigation
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: textColor,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected || index == 1
                        ? FontWeight.w600
                        : FontWeight.normal,
                    color: textColor,
                  ),
                ),
              ),
              if (hasSubmenu)
                Icon(
                  Icons.chevron_right,
                  size: 16,
                  color: Colors.black54,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper class to manage the sidebar state
class SidebarController {
  bool isOpen = false;
  final ValueNotifier<bool> sidebarVisibility = ValueNotifier<bool>(false);

  void toggleSidebar() {
    isOpen = !isOpen;
    sidebarVisibility.value = isOpen;
  }

  void openSidebar() {
    isOpen = true;
    sidebarVisibility.value = true;
  }

  void closeSidebar() {
    isOpen = false;
    sidebarVisibility.value = false;
  }
}
