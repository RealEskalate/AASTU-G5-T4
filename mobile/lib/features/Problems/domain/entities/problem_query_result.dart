import 'package:equatable/equatable.dart';
import 'package:mobile/features/Problems/domain/entities/problem_entity.dart'; // Adjust path

// Holds the result of fetching a list of problems, including pagination info.
class ProblemQueryResult extends Equatable {
  final List<ProblemEntity> problems;
  final int
      totalCount; // Total number of problems matching the filters (for pagination)

  const ProblemQueryResult({
    required this.problems,
    required this.totalCount,
  });

  @override
  List<Object> get props => [problems, totalCount];
}
