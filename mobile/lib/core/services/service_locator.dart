import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/features/Problems/data/data_sources/problem_remote_data_source.dart';
import 'package:mobile/features/Problems/data/repositories/problem_repository_impl.dart';
import 'package:mobile/features/Problems/domain/repositories/problem_repository.dart';
import 'package:mobile/features/Problems/domain/use_cases/get_problems.dart';
import 'package:mobile/features/Problems/presentation/bloc/problems/problems_bloc.dart';

// TODO: Import NetworkInfo if needed
// import 'package:mobile/core/network/network_info.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart'; // Example dependency for NetworkInfo

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // --- Features - Problems ---

  // Bloc (Factory - new instance each time)
  sl.registerFactory(
    () => ProblemsBloc(
        // *** Inject the ACTUAL Use Case now ***
        // getProblemsUseCase: sl(), // Uncomment when Bloc constructor expects it
        ),
  );

  // Use cases (Lazy Singleton - created only when first requested)
  sl.registerLazySingleton(() => GetProblemsUseCase(repository: sl()));

  // Repository (Lazy Singleton - register implementation AS interface)
  sl.registerLazySingleton<ProblemRepository>(
    () => ProblemRepositoryImpl(
      remoteDataSource: sl(),
      // networkInfo: sl(), // Inject if using network checks
      // localDataSource: sl(), // Inject if using caching
    ),
  );

  // Data sources (Lazy Singleton)
  sl.registerLazySingleton<ProblemRemoteDataSource>(
    () => ProblemRemoteDataSourceImpl(client: sl()),
  );
  // TODO: Register Local Data Source if needed
  // sl.registerLazySingleton<ProblemLocalDataSource>(() => ProblemLocalDataSourceImpl(sharedPreferences: sl()));

  // --- Core ---
  // TODO: Register NetworkInfo if needed
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // --- External ---
  sl.registerLazySingleton(() => http.Client());
  // sl.registerLazySingleton(() => InternetConnectionChecker()); // Example for NetworkInfo
  // final sharedPreferences = await SharedPreferences.getInstance(); // Example for local source
  // sl.registerLazySingleton(() => sharedPreferences);
}
