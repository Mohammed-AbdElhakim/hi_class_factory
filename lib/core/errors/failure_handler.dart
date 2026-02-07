// import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'failure.dart';
import 'firebase_failure.dart';
// import 'server_failure.dart';
import 'unknown_failure.dart';

class FailureHandler {
  static Failure handle(dynamic error) {
    // if (error is DioException) {
    //   return ServerFailure.fromDioException(error);
    // }

    if (error is FirebaseAuthException) {
      print("==========================");
      print(error);
      return FirebaseFailure.fromAuthException(error);
    }

    if (error is FirebaseException) {
      return FirebaseFailure.fromFirestoreException(error);
    }

    return const UnknownFailure();
  }
}
