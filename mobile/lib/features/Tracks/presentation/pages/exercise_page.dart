import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/features/Home/presentation/widgets/CustomappBar.dart';
import 'package:mobile/features/Home/presentation/widgets/sideBar.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // Create a sidebar controller
  final SidebarController _sidebarController = SidebarController();
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      key: _scaffoldKey,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Customappbar(
            onMenuPressed: () {
              _sidebarController.toggleSidebar();
            },
          )),
      // drawer: HubSidebarExample(),
      body: Stack(children: [
        SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Exercise",
                              style: GoogleFonts.publicSans(
                                  textStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700))),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Tracks",
                                  style: GoogleFonts.publicSans(
                                      textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400))),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 8),
                                child: Text('.',
                                    style: GoogleFonts.publicSans(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            color: Color.fromRGBO(
                                                145, 158, 171, 1),
                                            fontWeight: FontWeight.w900))),
                              ),
                              Text("Progress",
                                  style: GoogleFonts.publicSans(
                                      textStyle: TextStyle(
                                          fontSize: 14,
                                          color:
                                              Color.fromRGBO(145, 158, 171, 1),
                                          fontWeight: FontWeight.w400))),
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          // DropdownButton(items: [], onChanged: () {}),
                          ElevatedButton(
                              onPressed: () {}, child: Text("Expanded")),
                          ElevatedButton(
                              onPressed: () {}, child: Text("Expanded")),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        // Overlay sidebar when open
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
        ),
      ]),
    );
  }
}
