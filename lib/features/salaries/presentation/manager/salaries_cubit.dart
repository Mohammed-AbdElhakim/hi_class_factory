import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../attendance/data/models/attendance_model.dart';
import '../../data/repositories/salaries_repo.dart';

part 'salaries_state.dart';

class SalariesCubit extends Cubit<SalariesState> {
  final SalariesRepo repository;

  SalariesCubit(this.repository) : super(SalariesInitial());

  Future<void> getAttendance() async {
    emit(SalariesLoading());

    final result = await repository.getAttendance();

    result.fold(
      (failure) => emit(SalariesError(failure.errorMessage)),
      (attendanceList) => emit(SalariesSuccess(attendanceList)),
    );
  }
}

// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../data/repositories/salaries_repo.dart';
//
// part 'salaries_state.dart';
//
// class PayrollCubit extends Cubit<PayrollState> {
//   final PayrollRepo repo;
//
//   PayrollCubit(this.repo) : super(PayrollInitial());
//
//   Future<void> generateWeeklyPayroll({
//     required DateTime fromDate,
//     required DateTime toDate,
//   }) async {
//     emit(PayrollLoading());
//
//     final result = await repo.generateWeeklyPayroll(fromDate: fromDate, toDate: toDate);
//
//     result.fold((error) => emit(PayrollFailure(error)), (_) => emit(PayrollSuccess()));
//   }
// }
