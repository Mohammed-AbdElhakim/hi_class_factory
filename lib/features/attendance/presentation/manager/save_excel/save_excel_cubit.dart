import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/firebase/firebase_service.dart';
import '../../../data/models/attendance_record_model.dart';
import 'save_excel_state.dart';

class SaveExcelCubit extends Cubit<SaveExcelState> {
  SaveExcelCubit() : super(const SaveExcelState());

  // اختيار الملف وقراءة البيانات
  Future<void> pickAndReadExcel() async {
    emit(state.copyWith(status: SaveStatus.loading, data: [], error: null));

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls'],
        allowMultiple: false,
        withData: kIsWeb,
      );

      if (result == null) {
        emit(state.copyWith(status: SaveStatus.loading));
        return;
      }

      Uint8List bytes;
      if (kIsWeb) {
        bytes = result.files.first.bytes!;
      } else {
        bytes = await File(result.files.single.path!).readAsBytes();
      }

      final excel = Excel.decodeBytes(bytes);

      final data = _readExcelData(excel);

      emit(state.copyWith(status: SaveStatus.initial, data: data));
    } catch (e) {
      emit(state.copyWith(status: SaveStatus.loading, error: e.toString()));
    }
  }

  // رفع البيانات على Firebase
  Future<void> uploadToFirebase() async {
    // ✅ أول حاجة نتأكد إن المستخدم اختار فترة
    if (state.selectedRange == null) {
      emit(state.copyWith(error: "اختار الفترة الأول", status: SaveStatus.failure));
      return;
    }

    // ✅ نتأكد إن فيه بيانات أصلاً
    if (state.data.isEmpty) {
      emit(state.copyWith(error: "لا يوجد بيانات للرفع", status: SaveStatus.failure));
      return;
    }

    emit(state.copyWith(status: SaveStatus.loading));

    final firestore = FirebaseFirestore.instance;
    final factoryId = "hi_class";
    final String collectionName = "attendance";
    try {
      final fromDate = state.selectedRange!.start;
      final toDate = state.selectedRange!.end;
      // 🔹 1️⃣ إنشاء document للفترة
      final periodRef = firestore
          .collection(FirebaseService.collectionMain)
          .doc(factoryId)
          .collection(collectionName)
          .doc(); // auto id
      await periodRef.set({
        "id": periodRef.id,
        "fromDate": fromDate,
        "toDate": toDate,
        "monthLabel": "${fromDate.year}-${fromDate.month}",
        "createdAt": FieldValue.serverTimestamp(),
        "recordsCount": state.data.length,
      });
      // 🔹 2️⃣ رفع الحضور داخل Subcollection
      for (var i = 0; i < state.data.length; i += 500) {
        final batch = firestore.batch();
        final chunk = state.data.skip(i).take(500);

        for (var record in chunk) {
          final docRef = periodRef.collection("records").doc();
          batch.set(docRef, record.toJson());
        }

        await batch.commit();
      }

      emit(state.copyWith(status: SaveStatus.success));
    } catch (e) {
      emit(state.copyWith(status: SaveStatus.failure, error: e.toString()));
    }
  }

  // ---------------- دوال مساعدة ----------------
  List<AttendanceRecordModel> _readExcelData(Excel excel) {
    if (excel.tables.isEmpty) return [];

    final sheet = excel.tables[excel.tables.keys.first]!;
    if (sheet.rows.isEmpty) return [];

    final headers = sheet.rows.first
        .map((cell) => cell?.value?.toString() ?? "")
        .toList();

    List<AttendanceRecordModel> tempList = [];

    for (int i = 1; i < sheet.rows.length; i++) {
      final row = sheet.rows[i];
      Map<String, dynamic> json = {};

      for (int j = 0; j < headers.length; j++) {
        final key = headers[j];
        if (j < row.length) {
          final cell = row[j];
          dynamic value;
          if (cell == null || cell.value == null) {
            value = null;
          } else if (cell.value is num) {
            final numValue = cell.value as num;
            value = numValue % 1 == 0 ? numValue.toInt() : numValue;
          } else {
            value = cell.value.toString();
          }
          json[key] = value;
        } else {
          json[key] = null;
        }
      }

      tempList.add(AttendanceRecordModel.fromJson(json));
    }

    return tempList;
  }

  void setDateRange(DateTimeRange range) {
    emit(state.copyWith(selectedRange: range));
  }
}
