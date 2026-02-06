// import 'dart:convert';
//
// import 'package:dio/dio.dart';
//
// import 'failure.dart';
//
// class ServerFailure extends Failure {
//   const ServerFailure({required super.errorMessage, required super.type});
//
//   factory ServerFailure.fromDioException(DioException dioException) {
//     switch (dioException.type) {
//       case DioExceptionType.connectionTimeout:
//         return const ServerFailure(
//           errorMessage: "Connection timeout with server",
//           type: FailureType.network,
//         );
//       case DioExceptionType.sendTimeout:
//         return const ServerFailure(
//           errorMessage: "Send timeout with server",
//           type: FailureType.network,
//         );
//       case DioExceptionType.receiveTimeout:
//         return const ServerFailure(
//           errorMessage: "Receive timeout with server",
//           type: FailureType.network,
//         );
//       case DioExceptionType.badCertificate:
//         return const ServerFailure(
//           errorMessage: "Bad certificate from server",
//           type: FailureType.server,
//         );
//       case DioExceptionType.cancel:
//         return const ServerFailure(
//           errorMessage: "Request was cancelled",
//           type: FailureType.network,
//         );
//       case DioExceptionType.connectionError:
//         return const ServerFailure(
//           errorMessage: "No internet connection",
//           type: FailureType.network,
//         );
//       case DioExceptionType.badResponse:
//         return ServerFailure.fromResponse(
//           dioException.response?.statusCode,
//           dioException.response?.data,
//         );
//       case DioExceptionType.unknown:
//         return const ServerFailure(
//           errorMessage: "Unexpected error, please try again",
//           type: FailureType.unknown,
//         );
//     }
//   }
//
//   factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
//     if (statusCode == 400) {
//       if (response is String) {
//         return ServerFailure(errorMessage: response, type: FailureType.server);
//       }
//       return ServerFailure(
//         errorMessage: utf8.decode(response),
//         type: FailureType.unknown,
//       );
//     } else if (statusCode == 401 || statusCode == 403) {
//       return const ServerFailure(
//         errorMessage: "Unauthorized, please login again",
//         type: FailureType.unauthorized,
//       );
//     } else if (statusCode == 404) {
//       return const ServerFailure(
//         errorMessage: "Request not found",
//         type: FailureType.server,
//       );
//     } else if (statusCode == 500) {
//       return const ServerFailure(
//         errorMessage: "Internal server error",
//         type: FailureType.server,
//       );
//     } else {
//       return const ServerFailure(
//         errorMessage: "Something went wrong",
//         type: FailureType.unknown,
//       );
//     }
//   }
// }
