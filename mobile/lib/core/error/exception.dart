class ServerException implements Exception {
  final int? statusCode;
  final String? details;
  ServerException({this.statusCode, this.details});
}

class CacheException implements Exception {}

class NetworkException implements Exception {}

class ParsingException implements Exception {
  final String? details;
  ParsingException({this.details});
}
