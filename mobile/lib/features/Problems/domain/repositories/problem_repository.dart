import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/failure.dart';
import 'package:mobile/features/Problems/domain/entities/problem_entity.dart';
import 'package:mobile/features/Problems/domain/entities/problem_query_result.dart';
import 'package:mobile/features/Problems/presentation/widgets/data_table.dart';

// Defines the contract for fetching problem data, abstracting the source.
abstract class ProblemRepository {
  Future<Either<Failure, ProblemQueryResult>> getProblems({
    // Pagination
    required int page,
    required int limit,
    // Filters (nullable for optional filtering)
    List<String>? platforms,
    List<ProblemDifficultyLevel>? difficulties,
    List<String>? tags,
    bool? isSolved,
    // Sorting (nullable for default sorting)
    String? sortColumn,
    SortDirection? sortDirection,
    // Add other potential parameters like searchQuery
  });

  // TODO: Add other methods if needed (e.g., getProblemById, updateProblemStatus)
}
