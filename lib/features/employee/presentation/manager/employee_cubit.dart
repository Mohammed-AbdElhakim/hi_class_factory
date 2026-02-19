import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/employee_model.dart';
import '../../data/repositories/employee_repo.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  EmployeeCubit(this.repo) : super(EmployeeInitial());
  final EmployeeRepo repo;

  Future<void> getEmployee() async {
    emit(EmployeeLoading());

    final result = await repo.getEmployee();

    result.fold(
      (failure) => emit(EmployeeError(failure.errorMessage)),
      (employee) => emit(EmployeeSuccess(employee)),
    );
  }

  Future<void> addEmployee(EmployeeModel employee) async {
    emit(EmployeeLoading());

    final result = await repo.addEmployee(employee: employee);

    result.fold((failure) => emit(EmployeeError(failure.errorMessage)), (_) {
      if (state is EmployeeSuccess) {
        final currentProducts = (state as EmployeeSuccess).employee;
        final updatedProducts = List<EmployeeModel>.from(currentProducts)..add(employee);
        emit(EmployeeSuccess(updatedProducts));
      } else {
        getEmployee();
      }
    });
  }

  Future<void> deleteEmployee(String id) async {
    emit(EmployeeLoading());

    final result = await repo.deleteEmployee(id: id);

    result.fold((failure) => emit(EmployeeError(failure.errorMessage)), (_) {
      if (state is EmployeeSuccess) {
        final currentProducts = (state as EmployeeSuccess).employee;
        final updatedProducts = currentProducts.where((p) => p.id != id).toList();
        emit(EmployeeSuccess(updatedProducts));
      } else {
        getEmployee();
      }
    });
  }

  Future<void> updateEmployee(EmployeeModel employee) async {
    emit(EmployeeLoading());

    final result = await repo.updateEmployee(employee: employee);

    result.fold((failure) => emit(EmployeeError(failure.errorMessage)), (_) {
      if (state is EmployeeSuccess) {
        final currentProducts = (state as EmployeeSuccess).employee;
        final updatedProducts = currentProducts.map((p) {
          return p.id == employee.id ? employee : p;
        }).toList();
        emit(EmployeeSuccess(updatedProducts));
      } else {
        getEmployee();
      }
    });
  }
}
