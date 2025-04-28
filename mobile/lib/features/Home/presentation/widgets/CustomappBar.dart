import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/features/Home/presentation/widgets/sideBar.dart';
import 'chat_dialog.dart'; // Import the new dialog widget

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
  Widget build(BuildContext context) {
    // Define the image URL
    const String imageUrl =
        'https://storage.googleapis.com/a2sv_hub_bucket_2/images%2FNatnael%20Wondwoesn%20Solomon.jpeg';
    // Define the placeholder widget
    const Widget placeholder = CircleAvatar(
      radius: 20,
      backgroundColor: Colors.grey,
      child: Icon(
        Icons.person,
        color: Colors.white,
        size: 25,
      ),
    );

    return AppBar(
      backgroundColor: Colors.white,
      title: const Text(
        '',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      leadingWidth: 120,
      leading: Container(
        padding: const EdgeInsets.only(left: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              iconSize: 24,
              onPressed: () {
                // widget.onMenuPressed;
                // Use the callback if provided, otherwise open drawer directly
                if (widget.onMenuPressed != null) {
                  widget.onMenuPressed!();
                } else {
                  _sidebarController.toggleSidebar;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
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
        // FIXED: Using Wrap instead of Row for better flexibility
        Wrap(
          spacing: 8, // Horizontal space between items
          children: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(
                  Icons.settings_outlined,
                  color: Colors.black,
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
              icon: const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              padding: EdgeInsets.zero, // Reduce padding
              constraints: const BoxConstraints(), // Remove constraints
            ),
            Stack(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const FaIcon(FontAwesomeIcons.solidBell),
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
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '6',
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              color: Colors.white,
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
                      // Handle profile image tap
                    },
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: 36, // Slightly reduced size
                      height: 36, // Slightly reduced size
                      errorBuilder: (context, error, stackTrace) {
                        // print('Error loading profile image: $error');
                        return placeholder;
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const CircleAvatar(
                          radius: 18, // Slightly reduced size
                          backgroundColor: Colors.grey,
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
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
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
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
