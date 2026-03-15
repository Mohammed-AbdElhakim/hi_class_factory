import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'attendance_record_model.dart';

class AttendanceModel {
  final String? id; // Document ID من Firestore
  final DateTime? createdAt;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? monthLabel;
  final int? recordsCount;
  final List<AttendanceRecordModel> records; // القائمة اللي أنت عايزها

  AttendanceModel({
    this.id,
    this.createdAt,
    this.fromDate,
    this.toDate,
    this.monthLabel,
    this.recordsCount,
    this.records = const [], // Default value مهم جداً
  });

  // 🔥 من Firestore Document (مع التعامل مع Timestamp)
  factory AttendanceModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return AttendanceModel(
      id: doc.id,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      fromDate: (data['fromDate'] as Timestamp?)?.toDate(),
      toDate: (data['toDate'] as Timestamp?)?.toDate(),
      monthLabel: data['monthLabel'] as String?,
      recordsCount: data['recordsCount'] as int?,
      records: [], // الـ records بتجيلك من subcollection مش من نفس الدوكيومنت
    );
  }

  // 🔥 من Firestore Query (List of Documents)
  factory AttendanceModel.fromQuerySnapshot(
    QuerySnapshot snapshot,
    List<AttendanceRecordModel> recordsList,
  ) {
    if (snapshot.docs.isEmpty) return AttendanceModel(records: recordsList);

    final data = snapshot.docs.first.data() as Map<String, dynamic>;

    return AttendanceModel(
      id: snapshot.docs.first.id,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      fromDate: (data['fromDate'] as Timestamp?)?.toDate(),
      toDate: (data['toDate'] as Timestamp?)?.toDate(),
      monthLabel: data['monthLabel'] as String?,
      recordsCount: data['recordsCount'] as int?,
      records: recordsList,
    );
  }

  // 🔥 للتحويل إلى JSON (عشان التخزين أو APIs)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt?.toIso8601String(),
      'fromDate': fromDate?.toIso8601String(),
      'toDate': toDate?.toIso8601String(),
      'monthLabel': monthLabel,
      'recordsCount': recordsCount,
      'records': records.map((r) => r.toJson()).toList(),
    };
  }

  // 🔥 من JSON
  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'],
      createdAt: (json['createdAt'] as Timestamp).toDate(),

      fromDate: (json['fromDate'] as Timestamp).toDate(),

      toDate: (json['toDate'] as Timestamp).toDate(),
      monthLabel: json['monthLabel'],
      recordsCount: json['recordsCount'],
      records:
          (json['records'] as List?)
              ?.map((r) => AttendanceRecordModel.fromJson(r))
              .toList() ??
          [],
    );
  }

  // 🔥 CopyWith method (مهم جداً للـ State Management زي Cubit/BLoC)
  AttendanceModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? fromDate,
    DateTime? toDate,
    String? monthLabel,
    int? recordsCount,
    List<AttendanceRecordModel>? records,
  }) {
    return AttendanceModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      monthLabel: monthLabel ?? this.monthLabel,
      recordsCount: recordsCount ?? this.recordsCount,
      records: records ?? this.records,
    );
  }

  // 🔥 Helper Methods مفيدة
  bool get hasRecords => records.isNotEmpty;
  int get totalRecords => records.length;

  // فلترة الموظفين الغائبين مثلاً
  List<AttendanceRecordModel> getAbsentRecords() {
    return records
        .where((r) => r.absent?.toLowerCase() == 'yes' || r.absent == '1')
        .toList();
  }

  // فلترة المتأخرين
  List<AttendanceRecordModel> getLateRecords() {
    return records.where((r) {
      final late = r.late;
      return late != null && late.isNotEmpty && late != '00:00' && late != '-';
    }).toList();
  }

  @override
  String toString() {
    final locale = Intl.getCurrentLocale();

    if (locale.startsWith('ar')) {
      return 'من ${DateFormat('yyyy/MM/dd', 'en').format(fromDate!)} ← إلى ${DateFormat('yyyy/MM/dd', 'en').format(toDate!)}';
    } else {
      return 'From ${DateFormat('yyyy/MM/dd', 'en').format(fromDate!)} → To ${DateFormat('yyyy/MM/dd', 'en').format(toDate!)}';
    }
  }
}
