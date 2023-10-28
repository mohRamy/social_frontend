class ServerException implements Exception {
  final String messageError;
  ServerException({
    required this.messageError,
  });
}

class EmptyCacheException implements Exception {
  final String messageError;
  EmptyCacheException({
    required this.messageError,
  });
}

class OfflineException implements Exception {}


