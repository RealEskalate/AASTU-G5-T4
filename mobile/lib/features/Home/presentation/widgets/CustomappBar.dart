import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/core/theme/theme_toggle.dart';
import 'package:mobile/features/Home/presentation/widgets/sideBar.dart';
import 'chat_dialog.dart'; // Import the new dialog widget
import 'profile_menu_dialog.dart'; // Import the profile menu dialog

class Customappbar extends StatefulWidget {
  final VoidCallback? onMenuPressed; // Add this callback parameter

  const Customappbar({
    super.key,
    this.onMenuPressed, // Make it optional
  });

  @override
  State<Customappbar> createState() => _CustomappbarState();
}

class _CustomappbarState extends State<Customappbar> {
  final SidebarController _sidebarController = SidebarController();

  @override
  void dispose() {
    _sidebarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Define the image URL
    const String imageUrl =
        'https://storage.googleapis.com/a2sv_hub_bucket_2/images%2FNatnael%20Wondwoesn%20Solomon.jpeg';
    // Define the placeholder widget
    final Widget placeholder = CircleAvatar(
      radius: 20,
      backgroundColor: colorScheme.onSurface.withOpacity(0.3),
      child: Icon(
        Icons.person,
        color: colorScheme.onSurface,
        size: 25,
      ),
    );

    return AppBar(
      backgroundColor: colorScheme.surface,
      title: Text(
        '',
        style: TextStyle(color: colorScheme.onSurface),
      ),
      centerTitle: true,
      leadingWidth: 120,
      leading: Container(
        padding: const EdgeInsets.only(left: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.menu, color: colorScheme.onSurface),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              iconSize: 24,
              onPressed: () {
                // Use the callback if provided, otherwise open drawer directly
                if (widget.onMenuPressed != null) {
                  widget.onMenuPressed!();
                } else {
                  _sidebarController.toggleSidebar();
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.search, color: colorScheme.onSurface),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              iconSize: 24,
              onPressed: () {
                // Handle search button press
              },
            ),
          ],
        ),
      ),
      actions: [
        // Using Wrap instead of Row for better flexibility
        Wrap(
          spacing: 8, // Horizontal space between items
          children: [
            // Dark Mode Toggle
            ThemeToggle(useIconButton: true),
            Builder(
              builder: (context) => IconButton(
                icon: Icon(
                  Icons.settings_outlined,
                  color: colorScheme.onSurface,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                tooltip: 'Settings',
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ),
            IconButton(
              onPressed: () {
                // Show the chat dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const ChatDialog();
                  },
                );
              },
              icon: Icon(
                Icons.star,
                color: theme.brightness == Brightness.dark
                    ? Colors.amber.shade300
                    : Colors.amber,
              ),
              padding: EdgeInsets.zero, // Reduce padding
              constraints: const BoxConstraints(), // Remove constraints
            ),
            Stack(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.solidBell,
                    color: colorScheme.onSurface,
                  ),
                  padding: EdgeInsets.zero, // Reduce padding
                  constraints: const BoxConstraints(), // Remove constraints
                ),
                Positioned(
                  top: 1,
                  right: 2,
                  child: Card(
                    elevation: 10,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: colorScheme.error,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '6',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: colorScheme.onError,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 4), // Reduced spacing
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: GestureDetector(
                    onTap: () {
                      // Show the profile menu dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const ProfileMenuDialog();
                        },
                      );
                    },
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: 36, // Slightly reduced size
                      height: 36, // Slightly reduced size
                      errorBuilder: (context, error, stackTrace) {
                        return placeholder;
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return CircleAvatar(
                          radius: 18, // Slightly reduced size
                          backgroundColor:
                              colorScheme.onSurface.withOpacity(0.3),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                colorScheme.primary,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12, // Reduced size slightly
                    height: 12, // Reduced size slightly
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorScheme.surface,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 4), // Reduced spacing
          ],
        ),
      ],
    );
  }
}
