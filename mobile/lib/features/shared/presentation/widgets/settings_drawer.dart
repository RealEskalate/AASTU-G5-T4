import 'package:flutter/material.dart';
import 'package:mobile/core/theme/theme_notifier.dart';
import 'package:provider/provider.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Settings', style: Theme.of(context).textTheme.titleLarge),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.refresh), // Placeholder for refresh
                    onPressed: () {
                      // Optional: Reset settings?
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () =>
                        Navigator.of(context).pop(), // Close drawer
                  ),
                ],
              )
            ],
          ),
          const Divider(),

          // Mode Selection
          _buildSectionHeader(context, 'Mode'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildModeButton(
                context,
                icon: Icons.wb_sunny_outlined,
                label: 'Light',
                isSelected: themeNotifier.themeMode == ThemeMode.light,
                onTap: () => themeNotifier.setThemeMode(ThemeMode.light),
              ),
              _buildModeButton(
                context,
                icon: Icons.nightlight_outlined,
                label: 'Dark',
                isSelected: themeNotifier.themeMode == ThemeMode.dark,
                onTap: () => themeNotifier.setThemeMode(ThemeMode.dark),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Presets Selection - REMOVE THIS SECTION
          // _buildSectionHeader(context, 'Presets'),
          // Wrap(
          //   spacing: 10.0, // Horizontal space between chips
          //   runSpacing: 10.0, // Vertical space between rows
          //   alignment: WrapAlignment.center,
          //   children: [
          //     _buildColorChip(context, themeNotifier, defaultColor),
          //     _buildColorChip(context, themeNotifier, lightBlue),
          //     _buildColorChip(context, themeNotifier, red),
          //     _buildColorChip(context, themeNotifier, darkBlue),
          //     _buildColorChip(context, themeNotifier, amber),
          //   ],
          // ),
          // const SizedBox(height: 20),

          // --- Add other settings like Direction, Layout, Stretch from image if needed ---
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }

  Widget _buildModeButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : colorScheme.surface,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color:
                isSelected ? colorScheme.primary : colorScheme.outlineVariant,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? colorScheme.onPrimary
                  : colorScheme.onSurfaceVariant,
              size: 30,
            ),
            // Text(label, style: TextStyle(color: isSelected ? colorScheme.onPrimary : colorScheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}
