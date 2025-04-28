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
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

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
              color: theme.colorScheme.surface,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo section
                  Padding(
                    padding: const EdgeInsets.fromLTRB(1, 0, 16, 8),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Center(
                              child: Image.asset(
                                'assets/hub.png',
                                // colorFilter: ColorFilter.mode(
                                //   primaryColor,
                                //   BlendMode.srcIn,
                                // ),
                              ),
                            ),
                          ),
                        ),
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
                        color: theme.brightness == Brightness.dark
                            ? theme.colorScheme.surface.withOpacity(0.3)
                            : const Color(0xFFF5F5F5),
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
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  userRole,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.6),
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
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'STUDENT',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
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
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(
                            Icons.description_outlined,
                            color: theme.colorScheme.onPrimary,
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
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                fontSize: 12,
                                color: theme.colorScheme.onSurface
                                    .withOpacity(0.6),
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
    final theme = Theme.of(context);
    final isSelected = index == selectedIndex;

    // Use consistent color selection logic for all items
    final primaryColor = theme.colorScheme.primary;

    // Background color logic
    final backgroundColor = isSelected
        ? theme.brightness == Brightness.dark
            ? primaryColor.withOpacity(0.2)
            : const Color(0xFFE9FFF4)
        : Colors.transparent;

    // Text and icon color logic
    final textColor = isSelected ? primaryColor : theme.colorScheme.onSurface;

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
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: textColor,
                  ),
                ),
              ),
              if (hasSubmenu)
                Icon(
                  Icons.chevron_right,
                  size: 16,
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
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

  void dispose() {
    sidebarVisibility.dispose();
  }
}
