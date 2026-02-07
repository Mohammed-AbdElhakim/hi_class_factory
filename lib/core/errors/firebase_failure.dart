import 'package:firebase_auth/firebase_auth.dart';

import 'failure.dart';

class FirebaseFailure extends Failure {
  const FirebaseFailure({required super.errorMessage, required super.type});

  factory FirebaseFailure.fromAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return const FirebaseFailure(
          errorMessage: "No user found with this email",
          type: FailureType.firebase,
        );
      case 'wrong-password':
        return const FirebaseFailure(
          errorMessage: "Wrong password",
          type: FailureType.firebase,
        );
      case 'email-already-in-use':
        return const FirebaseFailure(
          errorMessage: "Email already in use",
          type: FailureType.firebase,
        );
      case 'invalid-email':
        return const FirebaseFailure(
          errorMessage: "Invalid email address",
          type: FailureType.firebase,
        );
      case 'weak-password':
        return const FirebaseFailure(
          errorMessage: "Password is too weak",
          type: FailureType.firebase,
        );
      case 'user-disabled':
        return const FirebaseFailure(
          errorMessage: "This user has been disabled",
          type: FailureType.unauthorized,
        );
      case 'too-many-requests':
        return const FirebaseFailure(
          errorMessage: "Too many requests, try later",
          type: FailureType.network,
        );
      case 'invalid-credential':
        return const FirebaseFailure(
          errorMessage: "The credential is invalid or has expired. Please login again.",
          type: FailureType.unauthorized,
        );
      default:
        return FirebaseFailure(
          errorMessage: e.message ?? "Authentication error",
          type: FailureType.firebase,
        );
    }
  }

  factory FirebaseFailure.fromFirestoreException(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return const FirebaseFailure(
          errorMessage: "Permission denied",
          type: FailureType.unauthorized,
        );
      case 'unavailable':
        return const FirebaseFailure(
          errorMessage: "Service unavailable",
          type: FailureType.network,
        );
      case 'not-found':
        return const FirebaseFailure(
          errorMessage: "Data not found",
          type: FailureType.firebase,
        );
      case 'deadline-exceeded':
        return const FirebaseFailure(
          errorMessage: "Request timeout",
          type: FailureType.network,
        );
      default:
        return FirebaseFailure(
          errorMessage: e.message ?? "Database error",
          type: FailureType.firebase,
        );
    }
  }
}
