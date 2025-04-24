import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For DateFormat
import 'package:mobile/features/Problems/domain/entities/problem_entity.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mobile/features/Problems/presentation/widgets/difficulty_chip.dart';
import 'package:mobile/features/Problems/presentation/widgets/problem_table_cell.dart';
import 'package:mobile/features/Problems/presentation/widgets/solved_status.dart';

// Represents a single row in the problems table.
class ProblemRow extends StatelessWidget {
  final ProblemEntity problem; // Takes the domain entity as input
  // Widths passed down from ProblemDataTable for consistent column sizing
  final double difficultyWidth;
  final double nameWidth;
  final double tagWidth;
  final double platformWidth;
  final double solvedWidth;
  final double addedWidth;
  final double voteWidth;
  final double linkWidth;
  final double height; // Height of the row

  const ProblemRow({
    required this.problem,
    required this.difficultyWidth,
    required this.nameWidth,
    required this.tagWidth,
    required this.platformWidth,
    required this.solvedWidth,
    required this.addedWidth,
    required this.voteWidth,
    required this.linkWidth,
    required this.height,
    super.key,
  });
  Future<void> _launchUrl(String urlString, BuildContext context) async {
    final Uri? uri = Uri.tryParse(urlString);
    if (uri != null) {
      // Now canLaunchUrl is recognized
      if (await canLaunchUrl(uri)) {
        try {
          // Now launchUrl and LaunchMode are recognized
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Could not launch $urlString: $e')),
            );
          }
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Could not launch $urlString - Unsupported URL')),
          );
        }
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Could not launch $urlString - Invalid URL format')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Define grey color consistently
    final Color iconColor = Colors.grey[600]!;
    final Color voteTextColor = Colors.grey[700]!;
    const double iconSize = 16.0;
    return Material(
      color: Colors.transparent, // Avoid background color conflicts
      child: InkWell(
        onTap: () {
          // TODO: Implement navigation to problem details page.
          // You might use Navigator.push, GoRouter, etc., passing problem.id or problem.link
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Navigate to: ${problem.name} (Not Implemented)')),
          );
        },
        child: SizedBox(
          height: height, // Enforce the row height
          child: Row(
            // Arranges the ProblemTableCells horizontally
            crossAxisAlignment: CrossAxisAlignment
                .center, // Vertically align content in the middle
            children: [
              // Difficulty Cell
              ProblemTableCell(
                width: difficultyWidth,
                // *** SET ALIGNMENT TO CENTER ***
                alignment: Alignment.center, // <--- ADD THIS
                // The DifficultyChip itself will size intrinsically
                child: DifficultyChip(difficulty: problem.difficultyLevel),
              ),
              // Name Cell
              ProblemTableCell(
                width: nameWidth,
                alignment: Alignment.centerLeft,
                child: Text(
                  problem.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow
                      .ellipsis, // Prevent long names from overflowing
                  maxLines: 2, // Allow slightly longer names to wrap
                ),
              ),
              // Tags Cell
              ProblemTableCell(
                width: tagWidth,
                child: Text(
                  // Join the list of tags, handle empty list
                  problem.tags.isEmpty ? '-' : problem.tags.join(', '),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2, // Allow tag lists to wrap slightly
                  style: theme.textTheme.bodySmall, // Use smaller text for tags
                ),
              ),
              // Platform Cell
              ProblemTableCell(
                width: platformWidth,
                alignment: Alignment.center, // Center the platform text
                child: Text(
                  problem.platform,
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: theme.hintColor), // Dimmer text
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Solved Status Cell
              ProblemTableCell(
                width: solvedWidth,
                alignment: Alignment.center, // Center the icon/text
                child: SolvedStatus(
                    solved: problem.isSolved), // Use the boolean field
              ),
              // Added Date Cell
              ProblemTableCell(
                width: addedWidth,
                alignment: Alignment.center, // Center the date text
                child: Text(
                  // Format the DateTime object using intl
                  DateFormat.yMd()
                      .format(problem.createdAt), // Example: "10/27/2023"
                  // You could use other formats like DateFormat.yMMMd() -> "Oct 27, 2023"
                  style: theme.textTheme.bodySmall, // Smaller text for date
                  textAlign: TextAlign.center,
                ),
              ),
              ProblemTableCell(
                width: voteWidth,
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Row takes minimum space
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center items in row
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Upvote Button
                    IconButton(
                      icon: Icon(Icons.arrow_upward,
                          size: iconSize, color: iconColor),
                      tooltip: 'Upvote',
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4), // Reduce padding
                      constraints: const BoxConstraints(), // Compact button
                      splashRadius: 18,
                      onPressed: () {
                        // TODO: Implement Upvote logic -> Dispatch event to Bloc
                        debugPrint('Upvote tapped for ${problem.id}');
                      },
                    ),
                    // Vote Count (Placeholder)
                    Padding(
                      // Add padding around the number for spacing
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        // TODO: Replace '0' with actual problem.voteCount from entity
                        '0',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: voteTextColor),
                      ),
                    ),
                    // Downvote Button
                    IconButton(
                      icon: Icon(Icons.arrow_downward,
                          size: iconSize, color: iconColor),
                      tooltip: 'Downvote',
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4), // Reduce padding
                      constraints: const BoxConstraints(), // Compact button
                      splashRadius: 18,
                      onPressed: () {
                        // TODO: Implement Downvote logic -> Dispatch event to Bloc
                        debugPrint('Downvote tapped for ${problem.id}');
                      },
                    ),
                  ],
                ),
              ),

              // --- Link Cell (UPDATED Icon) ---
              ProblemTableCell(
                width: linkWidth,
                alignment: Alignment.center,
                child: IconButton(
                  // Use the "open in new" icon and desired color
                  icon: Icon(Icons.open_in_new, size: 18, color: iconColor),
                  tooltip: 'Open problem link',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  splashRadius: 20,
                  onPressed: problem.link.isNotEmpty
                      ? () => _launchUrl(problem.link, context)
                      : null, // Disable if no link
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
