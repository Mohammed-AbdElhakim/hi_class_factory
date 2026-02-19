part of 'employee_cubit.dart';

sealed class EmployeeState extends Equatable {
  const EmployeeState();
  @override
  List<Object?> get props => [];
}

final class EmployeeInitial extends EmployeeState {}

final class EmployeeLoading extends EmployeeState {}

final class EmployeeError extends EmployeeState {
  final String message;

  const EmployeeError(this.message);

  @override
  List<Object?> get props => [message];
}

final class EmployeeSuccess extends EmployeeState {
  final List<EmployeeModel> employee;

  const EmployeeSuccess(this.employee);

  @override
  List<Object?> get props => [employee];
}
