part of 'salaries_cubit.dart';

sealed class SalariesState extends Equatable {
  const SalariesState();
  @override
  List<Object> get props => [];
}

final class SalariesInitial extends SalariesState {}

final class SalariesLoading extends SalariesState {}

class SalariesSuccess extends SalariesState {
  final SalariesDataModel attendanceAndEmployeesLists;
  const SalariesSuccess(this.attendanceAndEmployeesLists);
}

final class SalariesError extends SalariesState {
  final String message;
  const SalariesError(this.message);
}

// import 'package:flutter/material.dart';
//
// class PayrollState {
//   final DateTimeRange? selectedRange;
//   final bool isLoading;
//   final List<PayrollModel> data;
//   final String? error;
//
//   PayrollState({
//     this.selectedRange,
//     this.isLoading = false,
//     this.data = const [],
//     this.error,
//   });
//
//   PayrollState copyWith({
//     DateTimeRange? selectedRange,
//     bool? isLoading,
//     List<PayrollModel>? data,
//     String? error,
//   }) {
//     return PayrollState(
//       selectedRange: selectedRange ?? this.selectedRange,
//       isLoading: isLoading ?? this.isLoading,
//       data: data ?? this.data,
//       error: error,
//     );
//   }
// }
