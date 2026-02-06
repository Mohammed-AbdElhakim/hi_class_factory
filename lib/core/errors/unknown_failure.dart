import 'failure.dart';

class UnknownFailure extends Failure {
  const UnknownFailure({super.errorMessage = "Unexpected error occurred"})
    : super(type: FailureType.unknown);
}
