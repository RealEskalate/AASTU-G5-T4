import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/error/failure.dart';
import 'package:mobile/features/Problems/domain/entities/problem_entity.dart';
import 'package:mobile/features/Problems/domain/entities/problem_query_result.dart';
import 'package:mobile/features/Problems/domain/repositories/problem_repository.dart';
import 'package:mobile/features/Problems/presentation/widgets/data_table.dart';

class GetProblemsUseCase {
  final ProblemRepository repository;

  GetProblemsUseCase({required this.repository});

  Future<Either<Failure, ProblemQueryResult>> call(
      GetProblemsParams params) async {
    return await repository.getProblems(
      page: params.page,
      limit: params.limit,
      platforms: params.platforms,
      difficulties: params.difficulties,
      tags: params.tags,
      isSolved: params.isSolved,
      sortColumn: params.sortColumn,
      sortDirection: params.sortDirection,
    );
  }
}

class GetProblemsParams extends Equatable {
  final int page;
  final int limit;
  final List<String>? platforms;
  final List<ProblemDifficultyLevel>? difficulties;
  final List<String>? tags;
  final bool? isSolved;
  final String? sortColumn;
  final SortDirection? sortDirection;

  const GetProblemsParams({
    required this.page,
    required this.limit,
    this.platforms,
    this.difficulties,
    this.tags,
    this.isSolved,
    this.sortColumn,
    this.sortDirection,
  });

  @override
  List<Object?> get props => [
        page,
        limit,
        platforms,
        difficulties,
        tags,
        isSolved,
        sortColumn,
        sortDirection,
      ];
}
