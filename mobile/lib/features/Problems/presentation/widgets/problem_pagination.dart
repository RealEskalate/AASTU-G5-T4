import 'package:flutter/material.dart';

class ProblemPagination extends StatelessWidget {
  final int currentPage;
  final int itemsPerPage;
  final int totalRows;
  final ValueChanged<int>? onRowsPerPageChanged; // Callback if UI implemented
  final ValueChanged<int>? onPageChanged; // Callback for page buttons

  const ProblemPagination({
    required this.currentPage,
    required this.itemsPerPage,
    required this.totalRows,
    this.onRowsPerPageChanged, // Keep optional until UI exists
    this.onPageChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int startRow = totalRows == 0 ? 0 : (currentPage - 1) * itemsPerPage + 1;
    // Ensure endRow doesn't exceed totalRows
    int endRow = (currentPage * itemsPerPage < totalRows)
        ? currentPage * itemsPerPage
        : totalRows;

    bool canGoBack = currentPage > 1;
    bool canGoForward = (currentPage * itemsPerPage) < totalRows;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
      height: 56, // Standard height
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end, // Align controls to the right
        children: [
          Text('Rows per page:', style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(width: 8),
          // TODO: Replace Text with DropdownButton to allow changing itemsPerPage
          // If implementing dropdown, call onRowsPerPageChanged?.call(newValue);
          Text('$itemsPerPage',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(width: 24),
          // Display range and total
          Text('$startRow–$endRow of $totalRows',
              style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(width: 16),
          // Previous Page Button
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_left),
            iconSize: 20,
            tooltip: 'Previous page',
            // Disable if cannot go back, otherwise call callback
            onPressed:
                canGoBack ? () => onPageChanged?.call(currentPage - 1) : null,
            splashRadius: 20,
            constraints: const BoxConstraints(), // Compact button
            padding: const EdgeInsets.all(8), // Add padding for tap area
          ),
          // Next Page Button
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_right),
            iconSize: 20,
            tooltip: 'Next page',
            // Disable if cannot go forward, otherwise call callback
            onPressed: canGoForward
                ? () => onPageChanged?.call(currentPage + 1)
                : null,
            splashRadius: 20,
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(8),
          ),
        ],
      ),
    );
  }
}
