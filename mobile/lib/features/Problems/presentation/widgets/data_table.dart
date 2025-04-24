import 'package:flutter/material.dart';
import 'package:mobile/features/Problems/domain/entities/problem_entity.dart';

import 'package:mobile/features/Problems/presentation/widgets/header_cell.dart';
import 'package:mobile/features/Problems/presentation/widgets/problem_pagination.dart';
import 'package:mobile/features/Problems/presentation/widgets/problem_row.dart';
import 'package:mobile/features/Problems/presentation/widgets/toolbar.dart';

enum SortDirection { ascending, descending }

class ProblemDataTable extends StatelessWidget {
  final VoidCallback? onFiltersPressed;
  final List<ProblemEntity> problems;
  final String? currentSortColumn;
  final SortDirection? currentSortDirection;
  final Function(String columnId, SortDirection direction)? onSortChanged;
  final int currentPage;
  final int itemsPerPage;
  final int totalProblemCount;
  final ValueChanged<int>? onPageChanged;
  final ValueChanged<int>? onItemsPerPageChanged;
  final bool isLoadingMore;

  const ProblemDataTable({
    this.onFiltersPressed,
    required this.problems,
    this.currentSortColumn,
    this.currentSortDirection,
    this.onSortChanged,
    required this.currentPage,
    required this.itemsPerPage,
    required this.totalProblemCount,
    this.onPageChanged,
    this.onItemsPerPageChanged,
    this.isLoadingMore = false,
    super.key,
  });

  // --- Column Width Definitions (ADJUSTED) ---
  static const double difficultyWidth = 130.0; // Increased significantly
  static const double nameWidth = 200.0; // Slightly Increased
  static const double tagWidth = 150.0; // Slightly Increased
  static const double platformWidth = 150.0;
  static const double solvedWidth = 128.0;
  static const double addedWidth = 128.0;
  static const double voteWidth = 150.0;
  static const double linkWidth = 150.0;
  static const int numColumns = 8;

  // --- *** RE-CALCULATED totalWidth *** ---
  static const double totalInternalPadding =
      8.0 * numColumns; // 16px * 8 = 128.0
  static const double buffer = 0.0; // Increased buffer slightly
  static const double totalWidth = difficultyWidth +
      nameWidth +
      tagWidth +
      platformWidth +
      solvedWidth +
      addedWidth +
      voteWidth +
      linkWidth +
      totalInternalPadding +
      buffer;
  // Recalculated: 120+250+190+100+70+60+60+100 + 128 + 10 = 1088.0

  static const double headerHeight = 48.0;
  static const double rowHeight = 60.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProblemToolbar(onFiltersPressed: onFiltersPressed),
        const SizedBox(height: 16), // Space between toolbar and table
        const Divider(height: 1, thickness: 1),
        _buildHeaderRow(context), // Pass context for menu
        const Divider(height: 1, thickness: 1),
        Expanded(
          child: ListView.separated(
            itemCount: problems.length,
            itemBuilder: (context, index) {
              return ProblemRow(
                problem: problems[index],
                difficultyWidth: difficultyWidth,
                nameWidth: nameWidth,
                tagWidth: tagWidth,
                platformWidth: platformWidth,
                solvedWidth: solvedWidth,
                addedWidth: addedWidth,
                voteWidth: voteWidth,
                linkWidth: linkWidth,
                height: rowHeight,
              );
            },
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),
          ),
        ),
        const Divider(height: 1, thickness: 1),
        ProblemPagination(
          currentPage: currentPage,
          itemsPerPage: itemsPerPage,
          totalRows: totalProblemCount,
          onPageChanged: onPageChanged,
          onRowsPerPageChanged: onItemsPerPageChanged,
        ),
      ],
    );
  }

  // Header Row now includes menu logic
  Widget _buildHeaderRow(BuildContext context) {
    // Pass BuildContext
    void handleSort(String columnId) {
      if (onSortChanged == null) return;
      SortDirection newDirection;
      if (currentSortColumn == columnId) {
        newDirection = (currentSortDirection == SortDirection.ascending)
            ? SortDirection.descending
            : SortDirection.ascending;
      } else {
        newDirection = SortDirection.ascending;
      }
      onSortChanged!(columnId, newDirection);
    }

    // --- Function to show the popup menu ---
    void showHeaderMenu(
        BuildContext context, String columnId, RenderBox renderBox) {
      final position = renderBox.localToGlobal(Offset.zero);
      showMenu<String>(
        context: context,
        position: RelativeRect.fromLTRB(
            position.dx,
            position.dy + headerHeight,
            position.dx + renderBox.size.width,
            position.dy + headerHeight + 100), // Position below header
        items: [
          PopupMenuItem<String>(
            value: 'unsort',
            enabled: currentSortColumn ==
                columnId, // Only enable if currently sorted
            child: const Text('Unsort'),
            onTap: () {
              // TODO: Implement Unsort logic (maybe clear sort in Bloc?)
              // Could dispatch SortChanged with null direction/column? Need Bloc change.
              debugPrint('Unsort tapped for $columnId (Not implemented)');
            },
          ),
          PopupMenuItem<String>(
            value: 'sort_asc',
            child: const Text('Sort by ASC'),
            onTap: () => onSortChanged?.call(columnId, SortDirection.ascending),
          ),
          PopupMenuItem<String>(
            value: 'sort_desc',
            child: const Text('Sort by DESC'),
            onTap: () =>
                onSortChanged?.call(columnId, SortDirection.descending),
          ),
          const PopupMenuDivider(),
          PopupMenuItem<String>(
            value: 'filter',
            child: const Text('Filter'),
            onTap: () {
              // TODO: Implement filter dialog/panel trigger for this column
              debugPrint('Filter tapped for $columnId (Not implemented)');
            },
          ),
          PopupMenuItem<String>(
            value: 'hide',
            child: const Text('Hide'),
            onTap: () {
              // TODO: Implement column hiding logic (manage visible columns state)
              debugPrint('Hide tapped for $columnId (Not implemented)');
            },
          ),
          const PopupMenuDivider(),
          PopupMenuItem<String>(
            value: 'show_columns',
            child: const Text('Show columns'),
            onTap: () {
              // TODO: Implement dialog to manage all column visibility
              debugPrint('Show columns tapped (Not implemented)');
            },
          ),
        ],
        elevation: 8.0, // Standard elevation
      );
    }

    return SizedBox(
      height: headerHeight,
      child: Row(
        children: [
          // Pass sorting state and callback to each sortable HeaderCell
          HeaderCell(
            label: 'Difficulty', width: difficultyWidth,
            alignment: Alignment.center,
            isSorted: currentSortColumn == 'difficulty',
            sortDirection:
                currentSortColumn == 'difficulty' ? currentSortDirection : null,
            onSort: () => handleSort('difficulty'),
            // *** Implement onMenu callback ***
            onMenu: () {
              final RenderBox? renderBox =
                  context.findRenderObject() as RenderBox?;
              if (renderBox != null) {
                showHeaderMenu(context, 'difficulty', renderBox);
              }
            },
          ),
          HeaderCell(
            label: 'Name',
            width: nameWidth,
            isSorted: currentSortColumn == 'name',
            sortDirection:
                currentSortColumn == 'name' ? currentSortDirection : null,
            onSort: () => handleSort('name'),
            onMenu: () {
              final RenderBox? renderBox =
                  context.findRenderObject() as RenderBox?;
              if (renderBox != null) {
                showHeaderMenu(context, 'name', renderBox);
              }
            },
          ),
          HeaderCell(
            label: 'Tags',
            width: tagWidth,
            isSorted: currentSortColumn == 'tags',
            sortDirection:
                currentSortColumn == 'tags' ? currentSortDirection : null,
            onSort: () => handleSort('tags'),
            onMenu: () {
              final RenderBox? renderBox =
                  context.findRenderObject() as RenderBox?;
              if (renderBox != null) {
                showHeaderMenu(context, 'tags', renderBox);
              }
            },
          ),
          HeaderCell(
            label: 'Platform',
            width: platformWidth,
            alignment: Alignment.center,
            isSorted: currentSortColumn == 'platform',
            sortDirection:
                currentSortColumn == 'platform' ? currentSortDirection : null,
            onSort: () => handleSort('platform'),
            onMenu: () {
              final RenderBox? renderBox =
                  context.findRenderObject() as RenderBox?;
              if (renderBox != null) {
                showHeaderMenu(context, 'platform', renderBox);
              }
            },
          ),
          HeaderCell(
            label: 'Solved',
            width: solvedWidth,
            alignment: Alignment.center,
            isSorted: currentSortColumn == 'isSolved',
            sortDirection:
                currentSortColumn == 'isSolved' ? currentSortDirection : null,
            onSort: () => handleSort('isSolved'),
            onMenu: () {
              final RenderBox? renderBox =
                  context.findRenderObject() as RenderBox?;
              if (renderBox != null) {
                showHeaderMenu(context, 'isSolved', renderBox);
              }
            },
          ),
          HeaderCell(
            label: 'Added',
            width: addedWidth,
            alignment: Alignment.center,
            isSorted: currentSortColumn == 'createdAt',
            sortDirection:
                currentSortColumn == 'createdAt' ? currentSortDirection : null,
            onSort: () => handleSort('createdAt'),
            onMenu: () {
              final RenderBox? renderBox =
                  context.findRenderObject() as RenderBox?;
              if (renderBox != null) {
                showHeaderMenu(context, 'createdAt', renderBox);
              }
            },
          ),
          HeaderCell(
            label: 'Vote',
            width: voteWidth,
            alignment: Alignment.center,
            isSorted: currentSortColumn == 'voteCount',
            sortDirection:
                currentSortColumn == 'voteCount' ? currentSortDirection : null,
            onSort: () => handleSort('voteCount'),
            onMenu: () {
              final RenderBox? renderBox =
                  context.findRenderObject() as RenderBox?;
              if (renderBox != null) {
                showHeaderMenu(context, 'voteCount', renderBox);
              }
            },
          ),
          HeaderCell(
            // Link column menu (maybe just hide/show columns?)
            label: 'Link', width: linkWidth, alignment: Alignment.center,
            onMenu: () {
              final RenderBox? renderBox =
                  context.findRenderObject() as RenderBox?;
              if (renderBox != null) {
                showHeaderMenu(context, 'link', renderBox);
              }
            },
          ),
        ],
      ),
    );
  }
}
