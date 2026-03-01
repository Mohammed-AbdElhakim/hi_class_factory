// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../data/repositories/payroll_repo.dart';
//
// part 'payroll__state.dart';
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
