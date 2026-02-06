import 'package:equatable/equatable.dart';

enum FailureType { unauthorized, server, network, firebase, unknown }

abstract class Failure extends Equatable {
  final String errorMessage;
  final FailureType type;

  const Failure({required this.errorMessage, required this.type});

  @override
  List<Object?> get props => [errorMessage, type];
}
