part of 'problems_bloc.dart';

abstract class ProblemsEvent extends Equatable {
  const ProblemsEvent();

  @override
  List<Object?> get props =>
      []; // Include nullables in props if fields are nullable
}

// Event to trigger initial load or refresh with current filters/page
class FetchProblems extends ProblemsEvent {
  final bool refresh; // Flag to indicate if it's a refresh action

  const FetchProblems({this.refresh = false});

  @override
  List<Object?> get props => [refresh];
}

// Event when filters are changed/applied
class FiltersChanged extends ProblemsEvent {
  // Define filter parameters explicitly
  // Use null to indicate "no filter" for that criteria
  final List<String>? platforms;
  final List<ProblemDifficultyLevel>? difficulties;
  final List<String>? tags;
  final bool? isSolved;
  // Add more filters as needed (e.g., search query string)

  const FiltersChanged({
    this.platforms,
    this.difficulties,
    this.tags,
    this.isSolved,
  });

  @override
  List<Object?> get props => [platforms, difficulties, tags, isSolved];
}

// Event when the page number changes
class PageChanged extends ProblemsEvent {
  final int newPage;

  const PageChanged(this.newPage);

  @override
  List<Object?> get props => [newPage];
}

// Event when items per page setting changes
class ItemsPerPageChanged extends ProblemsEvent {
  final int newSize;

  const ItemsPerPageChanged(this.newSize);

  @override
  List<Object?> get props => [newSize];
}

// Event when sorting is applied
class SortChanged extends ProblemsEvent {
  final String columnId; // e.g., 'name', 'difficulty', 'createdAt'
  final SortDirection direction;

  const SortChanged({required this.columnId, required this.direction});

  @override
  List<Object?> get props => [columnId, direction];
}
