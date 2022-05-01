class CacheException implements Exception {}

class ServerException implements Exception {
  final String message;
  ServerException([this.message = "An unexpected error occur"]);
}

class invalidInputException implements Exception{}

class InvalidArgException implements Exception {}

class NoNetworkException implements Exception {}
