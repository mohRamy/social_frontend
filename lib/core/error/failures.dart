import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  Failure({
    required this.message,
  });
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure{
  ServerFailure({required super.message});
}

class EmptyCacheFailure extends Failure {
  EmptyCacheFailure({required super.message});
}

class OfflineFailure extends Failure {
  OfflineFailure({required super.message});
}


