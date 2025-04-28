import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileMenuDialog extends StatelessWidget {
  const ProfileMenuDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.only(top: 50, right: 10),
      alignment: Alignment.topRight,
      child: Container(
        width: 230,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'natnael.wondwoesn@...',
                style: TextStyle(
                  color: colorScheme.onSurface.withOpacity(0.8),
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Divider(height: 1),
            _buildMenuItem(context, 'Home', Icons.home_outlined,
                route: '/home'),
            _buildMenuItem(context, 'Profile', Icons.person_outline,
                route: '/profile'),
            _buildMenuItem(context, 'Settings', Icons.settings_outlined,
                route: '/settings'),
            _buildMenuItem(context, 'Sync leetcode', Icons.sync_outlined,
                route: '/sync-leetcode'),
            const Divider(height: 1),
            _buildMenuItem(context, 'Logout', Icons.logout_outlined,
                textColor: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, IconData icon,
      {Color? textColor, String? route}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListTile(
      dense: true,
      horizontalTitleGap: 8,
      leading: Icon(
        icon,
        color: textColor ?? colorScheme.onSurface,
        size: 20,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? colorScheme.onSurface,
          fontSize: 15,
        ),
      ),
      onTap: () {
        context.go(route ?? '/profile');
        // Handle menu item tap based on title
      },
    );
  }
}
