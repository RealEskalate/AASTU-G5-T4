import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/features/Home/presentation/widgets/CustomappBar.dart';
import 'package:mobile/features/Profile/presentation/widgets/profileCard.dart';

class UserprofilePage extends StatefulWidget {
  const UserprofilePage({super.key});

  @override
  State<UserprofilePage> createState() => _UserprofilePageState();
}

class _UserprofilePageState extends State<UserprofilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Customappbar(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile',
                    style: GoogleFonts.publicSans(),
                  ),
                  Row(
                    children: [
                      Text('Users'),
                      Text('. Natnael Wondwoesn Solomon')
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProfileCard(),
            ),
            // Action Icons
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Profile Icon
                  Column(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.white70,
                        size: 30,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Profile',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  // Problems Icon
                  Column(
                    children: [
                      Icon(
                        Icons.link,
                        color: Colors.white70,
                        size: 30,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Problems',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  // Settings/More Icon
                  Column(
                    children: [
                      Icon(
                        Icons.settings,
                        color: Colors.white70,
                        size: 30,
                      ),
                      SizedBox(height: 4),
                      Text(
                        '',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
