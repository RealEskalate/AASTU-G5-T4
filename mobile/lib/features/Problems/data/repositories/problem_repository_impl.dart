import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/core/error/exception.dart';
import 'package:mobile/core/error/failure.dart';
import 'package:mobile/features/Problems/data/data_sources/problem_remote_data_source.dart';
import 'package:mobile/features/Problems/domain/entities/problem_entity.dart';
import 'package:mobile/features/Problems/domain/entities/problem_query_result.dart';
import 'package:mobile/features/Problems/domain/repositories/problem_repository.dart';
import 'package:mobile/features/Problems/presentation/widgets/data_table.dart';

class ProblemRepositoryImpl implements ProblemRepository {
  final ProblemRemoteDataSource remoteDataSource;
  // TODO: Inject these if needed:
  // final ProblemLocalDataSource localDataSource;
  // final NetworkInfo networkInfo;

  ProblemRepositoryImpl({
    required this.remoteDataSource,
    // required this.localDataSource,
    // required this.networkInfo,
  });

  @override
  Future<Either<Failure, ProblemQueryResult>> getProblems({
    required int page,
    required int limit,
    List<String>? platforms,
    List<ProblemDifficultyLevel>? difficulties,
    List<String>? tags,
    bool? isSolved,
    String? sortColumn,
    SortDirection? sortDirection,
  }) async {
    // TODO: Implement network check if needed
    // if (await networkInfo.isConnected) {
    try {
      // Fetch from remote data source
      final (remoteProblemsModels, totalCount) =
          await remoteDataSource.getProblemsFromApi(
        page: page,
        limit: limit,
        platforms: platforms,
        difficulties: difficulties,
        tags: tags,
        isSolved: isSolved,
        sortColumn: sortColumn,
        sortDirection: sortDirection,
      );

      // Convert Models to Entities (often trivial if Model extends Entity)
      final List<ProblemEntity?> problemEntities =
          remoteProblemsModels.map((model) => model.toEntity()).toList();

      // Filter out null values from the list
      final List<ProblemEntity> nonNullableProblemEntities =
          problemEntities.whereType<ProblemEntity>().toList();

      // TODO: Implement caching logic here - save fetched data to localDataSource

      // Return success with entities and total count
      return Right(ProblemQueryResult(
          problems: nonNullableProblemEntities, totalCount: totalCount));
    } on ServerException catch (e) {
      return Left(ServerFailure(
          details: 'Status Code: ${e.statusCode} - ${e.details}'));
    } on ParsingException catch (e) {
      return Left(ParsingFailure(details: e.details));
    } on NetworkException {
      return const Left(NetworkFailure());
    } catch (e) {
      // Catch unexpected errors
      debugPrint("Unexpected error in Repository: $e");
      return Left(UnknownFailure(details: e.toString()));
    }
    // } else {
    //   // TODO: Implement logic to fetch from cache if offline
    //   try {
    //     final localProblems = await localDataSource.getLastProblems();
    //     return Right(ProblemQueryResult(problems: localProblems, totalCount: localProblems.length)); // Total count might be inaccurate from cache
    //   } on CacheException {
    //     return Left(CacheFailure());
    //   }
    // }
  }

  // TODO: Implement other repository methods
}
