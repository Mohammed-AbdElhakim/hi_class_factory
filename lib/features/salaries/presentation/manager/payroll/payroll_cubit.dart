import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/payroll_details_model.dart';
import '../../../data/repositories/salaries_repo.dart';

part 'payroll_state.dart';

class PayrollCubit extends Cubit<PayrollState> {
  final SalariesRepo repo;

  PayrollCubit(this.repo) : super(PayrollInitial());

  Future<void> loadPayroll(String payrollId) async {
    emit(PayrollLoading());

    final result = await repo.getPayroll(payrollId: payrollId);

    result.fold((l) => emit(PayrollError(l)), (r) => emit(PayrollLoaded(r)));
  }

  Future<void> savePayroll({required PayrollDetailsModel payrollDetails}) async {
    emit(PayrollSaving());
    final result = await repo.savePayroll(payrollDetails: payrollDetails);

    result.fold((l) => emit(PayrollError(l)), (_) => emit(PayrollLoaded(payrollDetails)));
  }
}
