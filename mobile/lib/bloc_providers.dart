import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/services/service_locator.dart';
import 'package:mobile/features/Problems/presentation/bloc/problems/problems_bloc.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> createBlocProviders() {
  return [
    BlocProvider<ProblemsBloc>(
      // Retrieve the Bloc instance registered in the Service Locator
      create: (_) => sl<ProblemsBloc>(),
    ),
    // Add other global BlocProviders here
  ];
}
