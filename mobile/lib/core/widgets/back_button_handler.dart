import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A widget that handles back button presses to prevent accidentally exiting the app.
/// Wraps a child widget and shows a confirmation dialog when back button is pressed.
class BackButtonHandler extends StatefulWidget {
  final Widget child;
  final String? exitTitle;
  final String? exitMessage;
  final String? stayButtonText;
  final String? exitButtonText;

  const BackButtonHandler({
    Key? key,
    required this.child,
    this.exitTitle,
    this.exitMessage,
    this.stayButtonText,
    this.exitButtonText,
  }) : super(key: key);

  @override
  State<BackButtonHandler> createState() => _BackButtonHandlerState();
}

class _BackButtonHandlerState extends State<BackButtonHandler> {
  // Track if back button was pressed recently (for double-tap to exit)
  DateTime? _lastBackPressTime;

  @override
  Widget build(BuildContext context) {
    // Using PopScope instead of WillPopScope, as it's the newer API
    return PopScope(
      canPop: false, // Prevent automatic popping
      onPopInvoked: (didPop) async {
        // If didPop is true, pop was already handled
        if (didPop) return;

        // Handle the pop request
        final shouldPop = await _onWillPop();
        if (shouldPop && context.mounted) {
          // If the user chose to exit, handle it by popping with result
          SystemNavigator.pop(); // This will close the app
        }
      },
      child: widget.child,
    );
  }

  Future<bool> _onWillPop() async {
    // Implementation 1: Show a dialog asking for confirmation
    return await _showExitConfirmationDialog();

    // Alternatively, you could use double-press logic:
    /*
    final now = DateTime.now();
    if (_lastBackPressTime == null || 
        now.difference(_lastBackPressTime!) > const Duration(seconds: 2)) {
      _lastBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Press back again to exit'),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
    return true;
    */
  }

  Future<bool> _showExitConfirmationDialog() async {
    if (!context.mounted) return false;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(widget.exitTitle ?? 'Exit App?'),
        content: Text(widget.exitMessage ??
            'Are you sure you want to exit the application?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // Cancel exit
            child: Text(widget.stayButtonText ?? 'Stay'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // Confirm exit
            child: Text(
              widget.exitButtonText ?? 'Exit',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    return result ?? false; // Default to false if dialog is dismissed
  }
}
