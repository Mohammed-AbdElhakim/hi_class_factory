part of 'attendance_cubit.dart';

sealed class AttendanceState extends Equatable {
  const AttendanceState();
  @override
  List<Object> get props => [];
}

final class AttendanceInitial extends AttendanceState {}

final class AttendanceLoading extends AttendanceState {}

class AttendancePeriodsLoaded extends AttendanceState {
  final List<AttendanceModel> periods;
  const AttendancePeriodsLoaded(this.periods);
}

class AttendanceRecordsLoaded extends AttendanceState {
  final List<AttendanceRecordModel> records;
  const AttendanceRecordsLoaded(this.records);
}

final class AttendanceError extends AttendanceState {
  final String message;
  const AttendanceError(this.message);
}
