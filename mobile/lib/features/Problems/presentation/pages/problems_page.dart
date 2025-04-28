import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/Home/presentation/widgets/CustomappBar.dart';
import 'package:mobile/features/Home/presentation/widgets/sideBar.dart';
import 'package:mobile/features/Problems/presentation/bloc/problems/problems_bloc.dart';
import 'package:mobile/features/Problems/presentation/widgets/data_table.dart';
import 'package:mobile/features/Problems/presentation/widgets/filtering.dart';
import 'package:mobile/features/Problems/presentation/widgets/header.dart';
// --- End Imports ---

class ProblemsPage extends StatefulWidget {
  const ProblemsPage({super.key});

  @override
  State<ProblemsPage> createState() => _ProblemsPageState();
}

class _ProblemsPageState extends State<ProblemsPage> {
  // --- State Variables ---
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // TODO: Ensure SidebarController is properly defined and potentially managed/disposed
  final SidebarController _sidebarController = SidebarController();
  int _selectedIndex = 0; // State for sidebar selection

  // --- Lifecycle Methods ---
  @override
  void initState() {
    super.initState();
    // Dispatch the initial event to load problems when the page is first built.
    // Assumes BlocProvider is above this widget in the tree (e.g., main.dart).
    context.read<ProblemsBloc>().add(const FetchProblems());
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _sidebarController.dispose();
    super.dispose();
  }

  // --- Helper Methods ---

  // Shows the filter selection dialog
  void _showFilterDialog(BuildContext context, ProblemFilters currentFilters) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      // barrierDismissible: false, // Optional: Prevent closing by tapping outside
      builder: (dialogContext) {
        // Provide the existing Bloc instance to the dialog's widget tree
        // This allows FilterDialogContent to dispatch events if needed (like Clear)
        // It uses context.read itself for the Apply button.
        return BlocProvider.value(
          value: BlocProvider.of<ProblemsBloc>(context), // Reuse existing Bloc
          child: AlertDialog(
            title: Text('Filter Problems',
                style: TextStyle(color: theme.colorScheme.onSurface)),
            backgroundColor: theme.colorScheme.surface,
            // Use the dedicated widget for dialog content and actions
            content: FilterDialogContent(initialFilters: currentFilters),
            actions: const [], // Actions are built into FilterDialogContent
            contentPadding: EdgeInsets.zero, // Let content handle padding
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
            scrollable: true, // Allows dialog content to scroll if needed
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)), // Optional styling
          ),
        );
      },
    );
  }

  // Determines which widget to show based on the current Bloc state
  Widget _buildContentForState(ProblemsState state, BuildContext context) {
    final theme = Theme.of(context);

    // Determine current filters from state, needed for the filter dialog callback
    ProblemFilters currentFilters = ProblemFilters.initial();
    ProblemsLoadSuccess?
        successState; // Hold the success state data if available

    if (state is ProblemsLoadSuccess) {
      currentFilters = state.currentFilters;
      successState = state;
    } else if (state is ProblemsLoadInProgress && state.isFilteringOrPaging) {
      // If loading more/filtering, try to find the previous success state
      // to keep displaying existing data while loading overlay is shown.
      final blocCurrentState = context.read<ProblemsBloc>().state;
      if (blocCurrentState is ProblemsLoadSuccess) {
        successState = blocCurrentState;
        currentFilters =
            successState.currentFilters; // Use filters from that state
      }
    }

    // Build UI based on the determined state
    if (state is ProblemsLoadInProgress && !state.isFilteringOrPaging) {
      // Initial full-screen loading
      return Center(
          child: CircularProgressIndicator(color: theme.colorScheme.primary));
    } else if (state is ProblemsLoadFailure) {
      // Error state
      return _buildErrorWidget(
          state.failure.message, context); // Use message from failure
    } else if (successState != null) {
      // Success state (or loading more/filtering state where we show previous data)
      // Create the callback function that will open the dialog
      VoidCallback filterCallback =
          () => _showFilterDialog(context, currentFilters);
      // Build the success widget, passing data and the callback
      return _buildSuccessWidget(
        successState,
        context,
        onFiltersPressed: filterCallback, // Pass the callback down
        isLoadingMore: state is ProblemsLoadInProgress, // Pass loading flag
      );
    } else {
      // Default/Initial state or unexpected loading state without previous data
      return Center(
          child: Text('Initializing...',
              style: TextStyle(color: theme.colorScheme.onBackground)));
    }
  }

  // Builds the UI for the error state
  Widget _buildErrorWidget(String message, BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: theme.colorScheme.error, size: 48),
            const SizedBox(height: 16),
            Text(message,
                style: TextStyle(color: theme.colorScheme.error),
                textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              // Dispatch event to refetch on retry
              onPressed: () => context
                  .read<ProblemsBloc>()
                  .add(const FetchProblems(refresh: true)),
              style: ElevatedButton.styleFrom(
                  foregroundColor: theme.colorScheme.onPrimary,
                  backgroundColor: theme.colorScheme.primary),
            )
          ],
        ),
      ),
    );
  }

  // Builds the UI for the success state (displays the table)
  Widget _buildSuccessWidget(ProblemsLoadSuccess state, BuildContext context,
      {required VoidCallback onFiltersPressed, // Callback to open filter dialog
      bool isLoadingMore = false}) {
    final theme = Theme.of(context);

    // Handle cases where the list is empty (either initially or after filtering)
    if (state.problems.isEmpty) {
      return Center(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          state.currentFilters.hasActiveFilters
              ? 'No problems match the current filters.'
              : 'No problems available.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onBackground.withOpacity(0.6)),
        ),
      ));
    }

    // Use a Stack to potentially overlay a loading indicator during background refreshes
    return Stack(
      children: [
        // Horizontal scrolling for the potentially wide table
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: ProblemDataTable
                .totalWidth, // Ensure SizedBox has defined width
            // The main data table widget
            child: ProblemDataTable(
              problems: state.problems,
              // Pass sorting state
              currentSortColumn: state.currentFilters.sortColumn,
              currentSortDirection: state.currentFilters.sortDirection,
              onSortChanged: (columnId, direction) {
                context
                    .read<ProblemsBloc>()
                    .add(SortChanged(columnId: columnId, direction: direction));
              },
              // Pass pagination state
              currentPage: state.currentPage,
              itemsPerPage: state.itemsPerPage,
              totalProblemCount: state.totalProblemCount,
              onPageChanged: (newPage) {
                context.read<ProblemsBloc>().add(PageChanged(newPage));
              },
              onItemsPerPageChanged: (newSize) {
                // Dispatch event if UI for changing size is implemented
                context.read<ProblemsBloc>().add(ItemsPerPageChanged(newSize));
              },
            ),
          ),
        ),
        // Show loading indicator when fetching more data or updating filters
        if (isLoadingMore)
          const Positioned.fill(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }

  // --- Main Build Method ---
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        // Use the standardized header height
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Customappbar(
          onMenuPressed: () {
            _sidebarController.toggleSidebar();
          },
        ),
      ),
      body: Stack(
        children: [
          // Main content area
          Container(
            // color: theme.scaffoldBackgroundColor, // Use scaffold BG for the main area too
            padding: const EdgeInsets.all(16.0), // Give some breathing room
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Static header for the page
                const ProblemHeader(),
                // Expanded section takes remaining space for the table/content
                Expanded(
                  child: BlocBuilder<ProblemsBloc, ProblemsState>(
                    builder: (context, state) {
                      return _buildContentForState(state, context);
                    },
                  ),
                ),
              ],
            ),
          ),

          // Overlay sidebar when open
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

// --- Example SidebarController ---
// Replace with your actual implementation or state management solution for the sidebar
class SidebarController {
  final ValueNotifier<bool> sidebarVisibility = ValueNotifier(false);
  void toggleSidebar() => sidebarVisibility.value = !sidebarVisibility.value;
  void closeSidebar() => sidebarVisibility.value = false;
  // Remember to dispose the ValueNotifier in the actual owning widget's dispose method
  void dispose() => sidebarVisibility.dispose();
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mobile/features/Home/presentation/widgets/CustomappBar.dart';
// import 'package:mobile/features/Home/presentation/widgets/sideBar.dart';
// import 'package:mobile/features/Problems/presentation/bloc/problems/problems_bloc.dart';
// import 'package:mobile/features/Problems/presentation/widgets/data_table.dart';
// import 'package:mobile/features/Problems/presentation/widgets/header.dart';

// class ProblemsPage extends StatefulWidget {
//   const ProblemsPage({super.key});

//   @override
//   State<ProblemsPage> createState() => _ProblemsPageState();
// }

// class _ProblemsPageState extends State<ProblemsPage> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final SidebarController _sidebarController = SidebarController();
//   int _selectedIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     context.read<ProblemsBloc>().add(const FetchProblems());
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return ValueListenableBuilder<bool>(
//       valueListenable: _sidebarController.sidebarVisibility,
//       builder: (context, isVisible, _) {
//         return Stack(
//           children: [
//             Scaffold(
//               key: _scaffoldKey,
//               backgroundColor: Colors.white,
//               appBar: PreferredSize(
//                 preferredSize: const Size.fromHeight(kToolbarHeight),
//                 child: Customappbar(
//                   onMenuPressed: () => _sidebarController.toggleSidebar(),
//                 ),
//               ),
//               body: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   // TODO: Pass filter state to ProblemHeader if it needs to display active filters
//                   const ProblemHeader(),
//                   Expanded(
//                     // Use BlocBuilder to react to state changes
//                     child: BlocBuilder<ProblemsBloc, ProblemsState>(
//                       builder: (context, state) {
//                         // Render loading, error, or success state
//                         if (state is ProblemsLoadInProgress &&
//                             !state.isFilteringOrPaging) {
//                           // Show full screen loading only for initial load
//                           return const Center(
//                               child: CircularProgressIndicator());
//                         } else if (state is ProblemsLoadFailure) {
//                           return _buildErrorWidget(state.errorMessage, context);
//                         } else if (state is ProblemsLoadSuccess) {
//                           return _buildSuccessWidget(state, context);
//                         } else if (state is ProblemsLoadInProgress &&
//                             state.isFilteringOrPaging) {
//                           // If already showing data, keep showing it but indicate loading
//                           // Find the previous success state to keep displaying data
//                           final previousState = context.select(
//                               (ProblemsBloc b) => b.state is ProblemsLoadSuccess
//                                   ? b.state as ProblemsLoadSuccess
//                                   : null);
//                           if (previousState != null) {
//                             return Stack(
//                               // Overlay loading indicator
//                               children: [
//                                 _buildSuccessWidget(previousState, context,
//                                     isLoadingMore: true),
//                                 Positioned.fill(
//                                   child: Container(
//                                     color: Colors.black.withOpacity(0.1),
//                                     child: const Center(
//                                         child: CircularProgressIndicator()),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           } else {
//                             // Fallback if no previous success state (shouldn't normally happen here)
//                             return const Center(
//                                 child: CircularProgressIndicator());
//                           }
//                         } else {
//                           // Initial state
//                           return const Center(child: Text('Initializing...'));
//                         }
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (isVisible)
//               HubSidebar(
//                 username: 'Natnael Wondwoesn Solomon',
//                 userRole: 'Student',
//                 userImageUrl: '...', // Your URL
//                 selectedIndex: _selectedIndex,
//                 onItemSelected: (index) {
//                   setState(() => _selectedIndex = index);
//                   _sidebarController.closeSidebar();
//                   // TODO: Handle navigation based on index
//                 },
//                 onClose: _sidebarController.closeSidebar,
//               ),
//           ],
//         );
//       },
//     );
//   }

//   // Helper widget for error state
//   Widget _buildErrorWidget(String message, BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(message,
//                 style: const TextStyle(color: Colors.red),
//                 textAlign: TextAlign.center),
//             const SizedBox(height: 10),
//             ElevatedButton.icon(
//               icon: const Icon(Icons.refresh),
//               label: const Text('Retry'),
//               onPressed: () => context
//                   .read<ProblemsBloc>()
//                   .add(const FetchProblems(refresh: true)),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   // Helper widget for success state (including empty)
//   Widget _buildSuccessWidget(ProblemsLoadSuccess state, BuildContext context,
//       {bool isLoadingMore = false}) {
//     if (state.problems.isEmpty && !state.currentFilters.hasActiveFilters) {
//       return const Center(child: Text('No problems available.'));
//     } else if (state.problems.isEmpty &&
//         state.currentFilters.hasActiveFilters) {
//       return const Center(
//           child: Text('No problems match the current filters.'));
//     }

//     // Pass necessary data and callbacks to ProblemDataTable
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: SizedBox(
//         width: ProblemDataTable.totalWidth,
//         // Pass data and callbacks
//         child: ProblemDataTable(
//           problems: state.problems,
//           // Pass sorting state
//           currentSortColumn: state.currentFilters.sortColumn,
//           currentSortDirection: state.currentFilters.sortDirection,
//           onSortChanged: (columnId, direction) {
//             context
//                 .read<ProblemsBloc>()
//                 .add(SortChanged(columnId: columnId, direction: direction));
//           },
//           // Pass pagination state & callbacks
//           currentPage: state.currentPage,
//           itemsPerPage: state.itemsPerPage,
//           totalProblemCount: state.totalProblemCount,
//           onPageChanged: (newPage) {
//             context.read<ProblemsBloc>().add(PageChanged(newPage));
//           },
//           onItemsPerPageChanged: (newSize) {
//             // TODO: Implement UI for changing items per page
//             // context.read<ProblemsBloc>().add(ItemsPerPageChanged(newSize));
//           },
//           // Pass filter state if needed by table/header directly
//           // currentFilters: state.currentFilters,
//           // Pass loading flag for potential UI hints
//           isLoadingMore: isLoadingMore,
//         ),
//       ),
//     );
//   }
// }

// // Example SidebarController - Replace with your actual implementation
// class SidebarController {
//   final ValueNotifier<bool> sidebarVisibility = ValueNotifier(false);
//   void toggleSidebar() => sidebarVisibility.value = !sidebarVisibility.value;
//   void closeSidebar() => sidebarVisibility.value = false;
//   void dispose() => sidebarVisibility.dispose();
// }
