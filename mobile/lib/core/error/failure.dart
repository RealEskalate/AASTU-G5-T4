import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;
  const Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => [properties];

  String get message => 'An unexpected error occurred.';
}

class ServerFailure extends Failure {
  final String? details;
  const ServerFailure({this.details});

  @override
  String get message =>
      details ?? 'Server Error: Could not process the request.';

  @override
  List<Object> get props => [details ?? ''];
}

class NetworkFailure extends Failure {
  const NetworkFailure();

  @override
  String get message => 'Network Error: Please check your connection.';
}

class CacheFailure extends Failure {
  const CacheFailure();

  @override
  String get message => 'Cache Error: Could not load data locally.';
}

class ParsingFailure extends Failure {
  final String? details;
  const ParsingFailure({this.details});

  @override
  String get message =>
      'Data Error: Could not parse the received data. ${details ?? ""}';

  @override
  List<Object> get props => [details ?? ''];
}

class UnknownFailure extends Failure {
  final String? details;
  const UnknownFailure({this.details});

  @override
  String get message => details ?? 'An unknown error occurred.';

  @override
  List<Object> get props => [details ?? ''];
}
