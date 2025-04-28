import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_generative_ai/google_generative_ai.dart'; // Import Gemini package
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv

// Remove the hardcoded key
// const String _apiKey = "...";

class ChatDialog extends StatefulWidget {
  const ChatDialog({super.key});

  @override
  State<ChatDialog> createState() => _ChatDialogState();
}

class _ChatDialogState extends State<ChatDialog> {
  final TextEditingController _controller = TextEditingController();
  late final GenerativeModel _model;
  late final ChatSession _chat;
  final List<({Image? image, String? text, bool fromUser})> _generatedContent =
      <({Image? image, String? text, bool fromUser})>[];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    // Get API key from environment
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null) {
      // Handle missing API key (e.g., show error, disable chat)
      // For now, we'll throw an error, but you might want a more graceful handling
      throw Exception('GEMINI_API_KEY not found in .env file');
      // Alternatively, you could disable the chat feature:
      // _model = null;
      // _chat = null;
      // return;
    }
    _model = GenerativeModel(
      // For text-only input, use the gemini-pro model
      model: 'gemini-1.5-flash',
      apiKey: apiKey, // Use the key from dotenv
    );
    _chat = _model.startChat();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Row containing the title and close button
          Row(
            mainAxisAlignment:
                MainAxisAlignment.end, // Align close button to the end
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10), // Adjusted spacing
          // Chat history display
          Expanded(
            // Make the chat history scrollable
            child: ListView.builder(
              itemCount: _generatedContent.length,
              itemBuilder: (context, index) {
                final content = _generatedContent[index];
                return MessageWidget(
                  text: content.text,
                  image: content.image,
                  isFromUser: content.fromUser,
                );
              },
            ),
          ),
          if (_loading) // Show loading indicator
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Center(child: CircularProgressIndicator()),
            ),
          const SizedBox(height: 10),
          // Placeholder for "Get Insights" UI (can be removed or adapted)
          // const Center(
          //   child: Column(
          //     children: [
          //       Icon(
          //         Icons.lightbulb_outline,
          //         size: 60,
          //         color: Colors.green,
          //       ),
          //       SizedBox(height: 10),
          //       Text('Get Insights'),
          //       SizedBox(height: 30),
          //       Icon(
          //         FontAwesomeIcons.question,
          //         size: 40,
          //         color: Colors.green,
          //       ),
          //     ],
          //   ),
          // ),
          // const SizedBox(height: 30),
          Center(
            child: Text(
              'Powered by Gemini',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Chat input field and send button
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  decoration: InputDecoration(
                    hintText: 'Type your message here...',
                    hintStyle: TextStyle(color: Theme.of(context).hintColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.outlineVariant),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    filled: true,
                    fillColor:
                        Theme.of(context).colorScheme.surface.withOpacity(0.5),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                  ),
                  onSubmitted: _sendMessage, // Allow sending with enter key
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.send, color: Theme.of(context).primaryColor),
                onPressed: _loading
                    ? null
                    : () =>
                        _sendMessage(_controller.text), // Disable while loading
              ),
            ],
          ),
          const SizedBox(height: 10), // Add some bottom padding
        ],
      ),
    );
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) {
      return; // Don't send empty messages
    }
    final message = text; // Save message before clearing controller
    _controller.clear();

    setState(() {
      _loading = true;
      _generatedContent.add((image: null, text: message, fromUser: true));
    });

    try {
      final response = await _chat.sendMessage(
        Content.text(message),
      );
      final responseText = response.text;
      if (responseText == null) {
        _showError('No response from API.');
        return;
      }
      setState(() {
        _generatedContent
            .add((image: null, text: responseText, fromUser: false));
      });
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _showError(String message) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Something went wrong',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onErrorContainer)),
          content: SingleChildScrollView(
            child: Text(message,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onErrorContainer)),
          ),
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// Simple widget to display chat messages
class MessageWidget extends StatelessWidget {
  final String? text;
  final Image? image;
  final bool isFromUser;

  const MessageWidget({
    super.key,
    this.text,
    this.image,
    required this.isFromUser,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          // Prevent overflow
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width *
                    0.7), // Max width for message bubble
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: isFromUser
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (text != null)
                  Text(text!,
                      style: TextStyle(
                        color: isFromUser
                            ? Theme.of(context).colorScheme.onPrimaryContainer
                            : Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                      )),
                if (image != null) image!,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
