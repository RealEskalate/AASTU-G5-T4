import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/features/Home/presentation/widgets/CustomappBar.dart';
import 'package:mobile/features/Home/presentation/widgets/sideBar.dart';
import 'package:mobile/features/Users/presentation/widgets/user_management_header.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // Create a sidebar controller
  final SidebarController _sidebarController = SidebarController();
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Customappbar(
            onMenuPressed: () {
              _sidebarController.toggleSidebar();
            },
          )),
      body: Stack(
        children: [
          SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Groups & Users',
                      style: GoogleFonts.publicSans(
                        textStyle: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w800),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'All',
                      style: GoogleFonts.publicSans(
                        textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(145, 158, 171, 1)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                UserManagementHeader(),
              ],
            ),
          )),
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
          )
        ],
      ),
    );
  }
}
