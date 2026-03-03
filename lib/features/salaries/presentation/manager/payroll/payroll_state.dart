part of 'payroll_cubit.dart';

@immutable
sealed class PayrollState {}

final class PayrollInitial extends PayrollState {}

final class PayrollLoading extends PayrollState {}

final class PayrollSaving extends PayrollState {}

final class PayrollLoaded extends PayrollState {
  final PayrollDetailsModel payrollDetails;
  PayrollLoaded(this.payrollDetails);
}

final class PayrollError extends PayrollState {
  final String message;
  PayrollError(this.message);
}
