import 'package:flutter/material.dart';

import '../../../data/models/attendance_record_model.dart';

enum SaveStatus { initial, loading, success, failure }

class SaveExcelState {
  final SaveStatus status;
  final List<AttendanceRecordModel> data;
  final String? error;
  final DateTimeRange? selectedRange;

  const SaveExcelState({
    this.status = SaveStatus.initial,
    this.data = const [],
    this.error,
    this.selectedRange,
  });

  SaveExcelState copyWith({
    SaveStatus? status,
    List<AttendanceRecordModel>? data,
    String? error,
    DateTimeRange? selectedRange,
  }) {
    return SaveExcelState(
      status: status ?? this.status,
      data: data ?? this.data,
      selectedRange: selectedRange ?? this.selectedRange,
      error: error,
    );
  }
}
