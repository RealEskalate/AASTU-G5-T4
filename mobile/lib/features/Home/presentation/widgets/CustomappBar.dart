import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Customappbar extends StatefulWidget {
  const Customappbar({super.key});

  @override
  State<Customappbar> createState() => _CustomappbarState();
}

class _CustomappbarState extends State<Customappbar> {
  @override
  Widget build(BuildContext context) {
    // Define the image URL
    const String imageUrl =
        'https://storage.googleapis.com/a2sv_hub_bucket_2/images%2FNatnael%20Wondwoesn%20Solomon.jpeg';
    // Define the placeholder widget
    const Widget placeholder = CircleAvatar(
      // Use CircleAvatar for consistency
      radius: 20, // Half of the desired width/height
      backgroundColor: Colors.grey, // Placeholder background color
      child: Icon(
        Icons.person, // Default user icon
        color: Colors.white,
        size: 25, // Adjust size as needed
      ),
    );

    return AppBar(
      backgroundColor: Colors.white,
      title: const Text(
        '',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,

      // FIXED: Replace leading with leadingWidth and a Container
      leadingWidth: 120, // Provide enough width for the icons
      leading: Container(
        padding: const EdgeInsets.only(left: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Make row take minimum space
          children: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              padding: EdgeInsets.zero, // Reduce padding
              constraints: const BoxConstraints(), // Remove constraints
              iconSize: 24, // Keep icon size reasonable
              onPressed: () {
                // Handle menu button press
              },
            ),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              padding: EdgeInsets.zero, // Reduce padding
              constraints: const BoxConstraints(), // Remove constraints
              iconSize: 24, // Keep icon size reasonable
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
            IconButton(
              onPressed: () {},
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
