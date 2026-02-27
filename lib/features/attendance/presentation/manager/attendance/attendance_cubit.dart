import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/attendance_model.dart';
import '../../../data/models/attendance_record_model.dart';
import '../../../data/repositories/attendance_repo.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final AttendanceRepo repository;

  AttendanceCubit(this.repository) : super(AttendanceInitial());

  Future<void> loadPeriods() async {
    emit(AttendanceLoading());

    final result = await repository.getAttendancePeriods();

    result.fold(
      (failure) => emit(AttendanceError(failure.errorMessage)),
      (periods) => emit(AttendancePeriodsLoaded(periods)),
    );
  }

  Future<void> loadRecords({required String periodId}) async {
    emit(AttendanceLoading());

    final result = await repository.getAttendanceRecords(periodId: periodId);

    result.fold(
      (failure) => emit(AttendanceError(failure.errorMessage)),
      (records) => emit(AttendanceRecordsLoaded(records)),
    );
  }

  Future<void> deletePeriod({required String periodId}) async {
    emit(AttendanceLoading());

    final result = await repository.deleteAttendancePeriod(periodId: periodId);

    result.fold((failure) => emit(AttendanceError(failure.errorMessage)), (_) async {
      // بعد الحذف نعمل reload للفترات
      await loadPeriods();
    });
  }
}
