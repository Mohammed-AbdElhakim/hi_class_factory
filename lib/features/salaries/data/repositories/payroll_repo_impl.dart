import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:hi_class_factory/core/firebase/firebase_service.dart';
import 'package:hi_class_factory/features/salaries/data/repositories/payroll_repo.dart';

import '../../../attendance/data/models/attendance_record_model.dart';
import '../../../employee/data/models/employee_model.dart';
import '../models/payroll_model.dart';

final int numberWeek = 4;
final int numberDay = 30;
final int numberWorkHour = 12;
final double numberOverTime = 1.5;

class PayrollRepoImpl implements PayrollRepo {
  @override
  Future<Either<String, void>> generateWeeklyPayroll({
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    try {
      final fireStore = FirebaseFirestore.instance;
      // 1️⃣ جلب الموظفين الفاعلين
      final employeesSnapshot = await fireStore
          .collection(FirebaseService.collectionMain)
          .doc(FirebaseService.factoryId)
          .collection('employees')
          .where('isActive', isEqualTo: true)
          .get();

      // 2️⃣ جلب كل الحضور
      final attendanceSnapshot = await fireStore
          .collection(FirebaseService.collectionMain)
          .doc(FirebaseService.factoryId)
          .collection('attendance')
          .where('fromDate', isEqualTo: Timestamp.fromDate(fromDate))
          .where('toDate', isEqualTo: Timestamp.fromDate(toDate))
          .get();

      List<AttendanceRecordModel> allRecords = [];
      for (var doc in attendanceSnapshot.docs) {
        // افترض ان كل doc فيه subcollection records
        final recordsSnap = await fireStore
            .collection(FirebaseService.collectionMain)
            .doc(FirebaseService.factoryId)
            .collection('attendance')
            .doc(doc.id)
            .collection('records')
            .get();

        allRecords.addAll(
          recordsSnap.docs.map((r) => AttendanceRecordModel.fromJson(r.data())).toList(),
        );
      }

      // 3️⃣ لكل موظف
      for (var empDoc in employeesSnapshot.docs) {
        final employee = EmployeeModel.fromJson(empDoc.data());

        // 3️⃣-أ: حساب ملخص الحضور
        final summary = calculateAttendanceSummary(
          acNo: int.parse(employee.acNo),
          records: allRecords,
        );

        // 3️⃣-ب: حساب المرتب الصافي
        final weeklyBase = employee.monthlySalary / numberWeek;
        final dailyRate = employee.monthlySalary / numberDay;
        final hourlyRate = dailyRate / numberWorkHour;

        final absenceDeduction = summary['absenceDays']!;
        final lateDeduction = summary['lateHours']!;
        final overtimeAmount = summary['overtimeHours']!;

        final netSalary =
            weeklyBase -
            (absenceDeduction * dailyRate) -
            (lateDeduction * hourlyRate) +
            (overtimeAmount * hourlyRate * numberOverTime);

        // 3️⃣-ج: حفظ Payroll
        await fireStore
            .collection(FirebaseService.collectionMain)
            .doc(FirebaseService.factoryId)
            .collection('payroll')
            .add(
              PayrollModel(
                employeeId: employee.id,
                fromDate: fromDate,
                toDate: toDate,
                weeklyBase: weeklyBase,
                absenceDeduction: absenceDeduction * dailyRate,
                lateDeduction: lateDeduction * hourlyRate,
                overtimeAmount: overtimeAmount * hourlyRate * numberOverTime,
                productionBonus: 0,
                netSalary: netSalary,
                isApproved: false,
                isPaid: false,
                createdAt: DateTime.now(),
              ).toJson(),
            );
      }

      return right(null);
    } catch (e) {
      return left(e.toString());
    }
  }

  // دالة مساعدة لحساب الغياب والتأخير والأوفر تايم
  Map<String, double> calculateAttendanceSummary({
    required int acNo,
    required List<AttendanceRecordModel> records,
  }) {
    int absenceDays = 0;
    double lateHours = 0;
    double overtimeHours = 0;

    final employeeRecords = records.where((r) => r.acNo == acNo).toList();

    for (var record in employeeRecords) {
      if (record.absent == '1' || record.absent?.toLowerCase() == 'yes') {
        absenceDays++;
      }

      if (record.late != null &&
          record.late!.isNotEmpty &&
          record.late != '00:00' &&
          record.late != '-') {
        final parts = record.late!.split(':');
        lateHours += double.parse(parts[0]) + (double.parse(parts[1]) / 60);
      }

      if (record.otTime != null && record.otTime!.isNotEmpty && record.otTime != '-') {
        final parts = record.otTime!.split(':');
        overtimeHours += double.parse(parts[0]) + (double.parse(parts[1]) / 60);
      }
    }

    return {
      'absenceDays': absenceDays.toDouble(),
      'lateHours': lateHours,
      'overtimeHours': overtimeHours,
    };
  }
}
