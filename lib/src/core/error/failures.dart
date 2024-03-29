import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({
    required this.message,
  });
  
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure{
  const ServerFailure({required super.message});
}

class LocalFailure extends Failure {
  const LocalFailure({required super.message});
}

class OfflineFailure extends Failure {
  const OfflineFailure({required super.message});
}