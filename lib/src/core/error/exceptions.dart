class ServerException implements Exception {
  final String messageError;
  ServerException({
    required this.messageError,
  });
}

class LocalException implements Exception {
  final String messageError;
  LocalException({
    required this.messageError,
  });
}

class OfflineException implements Exception {}


