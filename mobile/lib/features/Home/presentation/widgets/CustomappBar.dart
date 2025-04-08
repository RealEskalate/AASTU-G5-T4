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
    return AppBar(
      backgroundColor: Colors.white,
      title: const Text(
        '',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      leading: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              // Handle menu button press
            },
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Handle search button press
            },
          )
        ],
      ),
      actions: [
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.star,
                  color: Colors.amber,
                )),
            Stack(children: [
              IconButton(
                onPressed: () {},
                icon: FaIcon(FontAwesomeIcons.solidBell),
              ),
              Positioned(
                  top: 1,
                  right: 2,
                  child: Card(
                    elevation: 10,
                    child: Container(
                      width: 20, // Dot size
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.red, // Dot color
                        shape: BoxShape.circle, // Makes it circular
                        border: Border.all(
                          color: Colors
                              .white, // Optional: white border for contrast
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '6',
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800)),
                        ),
                      ),
                    ),
                  ))
            ]),
            Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: GestureDetector(
                  onTap: () {},
                  child: Image.network(
                      fit: BoxFit.cover,
                      width: 40,
                      height: 40,
                      'https://storage.googleapis.com/a2sv_hub_bucket_2/images%2FNatnael%20Wondwoesn%20Solomon.jpeg'),
                ),
              ),
              Positioned(
                  right: 2,
                  bottom: 0.01,
                  child: Container(
                    width: 16, // Dot size
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.green, // Dot color
                      shape: BoxShape.circle, // Makes it circular
                      border: Border.all(
                        color:
                            Colors.white, // Optional: white border for contrast
                        width: 2,
                      ),
                    ),
                  ))
            ])
          ],
        )
      ],
    );
  }
}
