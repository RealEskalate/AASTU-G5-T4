import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/Problems/domain/entities/problem_entity.dart';
import 'package:mobile/features/Problems/presentation/bloc/problems/problems_bloc.dart';

class FilterDialogContent extends StatefulWidget {
  final ProblemFilters initialFilters; // Pass current filters to pre-select

  const FilterDialogContent({
    required this.initialFilters,
    super.key,
  });

  @override
  State<FilterDialogContent> createState() => _FilterDialogContentState();
}

class _FilterDialogContentState extends State<FilterDialogContent> {
  // Local state for selections within the dialog
  late Set<ProblemDifficultyLevel> _selectedDifficulties;
  late TextEditingController _tagsController;

  @override
  void initState() {
    super.initState();
    // Initialize local state from the initial filters passed in
    _selectedDifficulties = widget.initialFilters.difficulties?.toSet() ?? {};
    _tagsController = TextEditingController(
      text:
          widget.initialFilters.tags?.join(', ') ?? '', // Join tags for display
    );
  }

  @override
  void dispose() {
    _tagsController.dispose();
    super.dispose();
  }

  // Function called when "Apply" is pressed
  void _applyFilters() {
    // Parse tags from the text controller
    final List<String> tags = _tagsController.text
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toList();

    // Create the FiltersChanged event
    final event = FiltersChanged(
      // Pass null if the set/list is empty, otherwise pass the list
      difficulties: _selectedDifficulties.isNotEmpty
          ? _selectedDifficulties.toList()
          : null,
      tags: tags.isNotEmpty ? tags : null,
      // Keep other filters (like platform, solved) as they were initially
      // or add UI elements for them here if needed
      platforms: widget.initialFilters.platforms,
      isSolved: widget.initialFilters.isSolved,
    );

    // Dispatch the event using context.read (safe because dialog is built with context)
    context.read<ProblemsBloc>().add(event);
    Navigator.of(context).pop(); // Close the dialog
  }

  // Function called when "Clear" is pressed
  void _clearFilters() {
    // Clear local state
    setState(() {
      _selectedDifficulties.clear();
      _tagsController.clear();
    });
    // Optionally apply the cleared filters immediately by dispatching event
    // context.read<ProblemsBloc>().add(const FiltersChanged(difficulties: null, tags: null));
    // Navigator.of(context).pop();
    // OR just clear locally and wait for Apply/Cancel
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      // Allow content to scroll if it overflows
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Take minimum vertical space
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Difficulty Filter ---
          Text('Difficulty', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            // Arrange chips, wrapping if necessary
            spacing: 8.0, // Horizontal space between chips
            runSpacing: 4.0, // Vertical space between rows of chips
            children: ProblemDifficultyLevel.values
                .where((d) =>
                    d !=
                    ProblemDifficultyLevel.unknown) // Exclude 'unknown' option
                .map((difficulty) {
              final isSelected = _selectedDifficulties.contains(difficulty);
              return FilterChip(
                label: Text(difficulty.name[0].toUpperCase() +
                    difficulty.name.substring(1)), // Capitalize enum name
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedDifficulties.add(difficulty);
                    } else {
                      _selectedDifficulties.remove(difficulty);
                    }
                  });
                },
                selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
                checkmarkColor: Theme.of(context).primaryColor,
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // --- Tag Filter ---
          Text('Tags (comma-separated)', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          TextField(
            controller: _tagsController,
            decoration: InputDecoration(
              hintText: 'e.g., Array, DP, Graphs',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
          const SizedBox(height: 24),

          // --- Action Buttons ---
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: _clearFilters,
                child: const Text('Clear'),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () => Navigator.of(context).pop(), // Just close
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _applyFilters,
                child: const Text('Apply'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
