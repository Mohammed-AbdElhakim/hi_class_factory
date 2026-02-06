import 'package:dartz/dartz.dart';

import '../errors/failure.dart';
import '../errors/global_failure_handler.dart';

extension EitherX<T> on Either<Failure, T> {
  void handleWithCubit({
    required void Function(T data) onSuccess,
    required void Function(String message) onError,
  }) {
    fold(
      (failure) => GlobalFailureHandler.handle(failure: failure, onError: onError),
      onSuccess,
    );
  }
}
