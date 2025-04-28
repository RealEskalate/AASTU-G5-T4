import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_notifier.dart';

class ThemeToggle extends StatelessWidget {
  final bool useIconButton;

  const ThemeToggle({
    Key? key,
    this.useIconButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    if (useIconButton) {
      return IconButton(
        icon: Icon(
          themeNotifier.isDarkMode ? Icons.light_mode : Icons.dark_mode,
        ),
        onPressed: () {
          themeNotifier.toggleTheme();
        },
        tooltip: themeNotifier.isDarkMode
            ? 'Switch to Light Mode'
            : 'Switch to Dark Mode',
      );
    }

    return Switch(
      value: themeNotifier.isDarkMode,
      onChanged: (value) {
        themeNotifier.toggleTheme();
      },
      activeColor: Theme.of(context).colorScheme.primary,
    );
  }
}
