part of 'problems_bloc.dart';

// Define a simple Filters class (or use a dedicated package like Freezed)
// To hold the current filter values. This is part of the state.
class ProblemFilters extends Equatable {
  final List<String>? platforms;
  final List<ProblemDifficultyLevel>? difficulties;
  final List<String>? tags;
  final bool? isSolved;
  final String? sortColumn;
  final SortDirection? sortDirection;

  const ProblemFilters({
    this.platforms,
    this.difficulties,
    this.tags,
    this.isSolved,
    this.sortColumn,
    this.sortDirection,
  });

  // Initial empty filters
  factory ProblemFilters.initial() => const ProblemFilters();

  // copyWith for easy updates
  ProblemFilters copyWith({
    ValueGetter<List<String>?>? platforms,
    ValueGetter<List<ProblemDifficultyLevel>?>? difficulties,
    ValueGetter<List<String>?>? tags,
    ValueGetter<bool?>? isSolved,
    ValueGetter<String?>? sortColumn,
    ValueGetter<SortDirection?>? sortDirection,
  }) {
    return ProblemFilters(
      platforms: platforms != null ? platforms() : this.platforms,
      difficulties: difficulties != null ? difficulties() : this.difficulties,
      tags: tags != null ? tags() : this.tags,
      isSolved: isSolved != null ? isSolved() : this.isSolved,
      sortColumn: sortColumn != null ? sortColumn() : this.sortColumn,
      sortDirection:
          sortDirection != null ? sortDirection() : this.sortDirection,
    );
  }

  // Helper to check if any filters are active
  bool get hasActiveFilters =>
      (platforms != null && platforms!.isNotEmpty) ||
      (difficulties != null && difficulties!.isNotEmpty) ||
      (tags != null && tags!.isNotEmpty) ||
      isSolved != null;

  @override
  List<Object?> get props =>
      [platforms, difficulties, tags, isSolved, sortColumn, sortDirection];
}

abstract class ProblemsState extends Equatable {
  const ProblemsState();

  @override
  List<Object?> get props => [];
}

class ProblemsInitial extends ProblemsState {}

// Loading state - could add a flag indicating if it's loading more/filtering vs initial
class ProblemsLoadInProgress extends ProblemsState {
  final bool isFilteringOrPaging; // Differentiate background loading
  const ProblemsLoadInProgress({this.isFilteringOrPaging = false});
  @override
  List<Object?> get props => [isFilteringOrPaging];
}

// Success state now holds pagination and filter info
class ProblemsLoadSuccess extends ProblemsState {
  final List<ProblemEntity> problems;
  final int totalProblemCount;
  final int currentPage;
  final int itemsPerPage;
  final ProblemFilters currentFilters; // Include active filters
  final bool canLoadMore; // Helper flag derived from total and current

  const ProblemsLoadSuccess({
    required this.problems,
    required this.totalProblemCount,
    required this.currentPage,
    required this.itemsPerPage,
    required this.currentFilters,
  }) : canLoadMore = (currentPage * itemsPerPage) < totalProblemCount;

  @override
  List<Object?> get props => [
        problems, // Compare lists by identity/content via Equatable
        totalProblemCount,
        currentPage,
        itemsPerPage,
        currentFilters,
        canLoadMore,
      ];

  // copyWith is very useful here for updates during pagination/filtering
  ProblemsLoadSuccess copyWith({
    List<ProblemEntity>? problems,
    int? totalProblemCount,
    int? currentPage,
    int? itemsPerPage,
    ProblemFilters? currentFilters,
    bool? isLoadingMore, // Optional flag for loading indicator at bottom
  }) {
    return ProblemsLoadSuccess(
      problems: problems ?? this.problems,
      totalProblemCount: totalProblemCount ?? this.totalProblemCount,
      currentPage: currentPage ?? this.currentPage,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage,
      currentFilters: currentFilters ?? this.currentFilters,
    );
  }
}

class ProblemsLoadFailure extends ProblemsState {
  final Failure failure; // Store the actual Failure object
  const ProblemsLoadFailure(this.failure);

  String get errorMessage => failure.message; // Delegate message retrieval

  @override
  List<Object?> get props => [failure];
}
