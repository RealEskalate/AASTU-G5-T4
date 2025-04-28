import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/features/Home/presentation/widgets/CustomappBar.dart';
import 'package:mobile/features/Home/presentation/widgets/sideBar.dart';
import 'package:mobile/features/Tracks/presentation/pages/progress_screen.dart';

class TracksPage extends StatefulWidget {
  const TracksPage({super.key});

  @override
  State<TracksPage> createState() => _TracksPageState();
}

class _TracksPageState extends State<TracksPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // Create a sidebar controller
  final SidebarController _sidebarController = SidebarController();
  int _selectedIndex = 1;

  @override
  void dispose() {
    _sidebarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Customappbar(
            onMenuPressed: () {
              _sidebarController.toggleSidebar();
            },
          )),
      // drawer: HubSidebarExample(),
      body: Stack(
        children: [
          ProgressScreen(solved: 200, available: 100, total: 300),
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
