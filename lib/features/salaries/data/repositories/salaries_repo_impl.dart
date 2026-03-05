import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hi_class_factory/core/errors/failure.dart';
import 'package:hi_class_factory/core/firebase/firebase_service.dart';
import 'package:hi_class_factory/features/attendance/data/models/attendance_model.dart';
import 'package:hi_class_factory/features/salaries/data/repositories/salaries_repo.dart';

import '../../../../core/errors/failure_handler.dart';
import '../../../../core/errors/unknown_failure.dart';
import '../../../attendance/data/models/attendance_record_model.dart';
import '../../../employee/data/models/employee_model.dart';
import '../models/employee_payroll_model.dart';
import '../models/payroll_details_model.dart';
import '../models/payroll_model.dart';
import '../models/salaries_data_model.dart';

final int numberWeek = 4;
final int numberDay = 30;
final int numberWorkHour = 12;
final double numberOverTime = 1.5;

class SalariesRepoImpl implements SalariesRepo {
  final FirebaseService firebaseService;

  SalariesRepoImpl(this.firebaseService);
  @override
  Future<Either<Failure, SalariesDataModel>> getAttendanceAndEmployees() async {
    List<AttendanceModel> attendanceList = [];
    try {
      // 1️⃣ الخطوة الأولى: جلب قائمة الـ Attendance الرئيسية
      QuerySnapshot attendanceSnapshot = await firebaseService.fireStore
          .collection('attendance')
          .orderBy('createdAt', descending: true) // ترتيب بالأحدث
          .get();

      // 2️⃣ الخطوة الثانية: الدوران على كل Document
      for (var doc in attendanceSnapshot.docs) {
        // أ) تحويل بيانات الـ Document الرئيسي لـ Model
        AttendanceModel attendance = AttendanceModel.fromFirestore(doc);

        // ب) جلب الـ Subcollection 'records' الخاصة بهذا الـ attendance
        QuerySnapshot recordsSnapshot = await firebaseService.fireStore
            .collection('attendance')
            .doc(doc.id) // مهم جداً: نحدد الـ ID بتاع الأب
            .collection('records')
            .get();
        // ج) تحويل سجلات الـ records لقائمة من AttendanceRecordModel
        List<AttendanceRecordModel> records = recordsSnapshot.docs
            .map(
              (recordDoc) => AttendanceRecordModel.fromJson(
                recordDoc.data() as Map<String, dynamic>,
              ),
            )
            .toList();

        // د) استخدام copyWith عشان نحقن الـ records جوه الموديل الرئيسي
        // (لأن fromFirestore جابتها فاضية في الأول)
        attendanceList.add(attendance.copyWith(records: records));
      }
      //الحصول على الموظفين
      final snapshot = await firebaseService.getAll(collection: "employees");
      final employeesList = snapshot.docs
          .map((doc) => EmployeeModel.fromJson(doc.data()))
          .toList();
      return right(
        SalariesDataModel(attendanceList: attendanceList, employeesList: employeesList),
      );
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return Left(UnknownFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<String, PayrollDetailsModel>> getPayroll({
    required String payrollId,
  }) async {
    try {
      final doc = await firebaseService.fireStore
          .collection('payrolls')
          .doc(payrollId)
          .get();
      if (!doc.exists) return Left("لم يتم العثور على كشوف المرتبات");

      final payroll = PayrollModel.fromJson(doc.id, doc.data()!);

      final employeesSnapshot = await doc.reference.collection('employeesPayroll').get();
      final employeesPayroll = employeesSnapshot.docs
          .map((e) => EmployeePayrollModel.fromJson(e.data()))
          .toList();

      return Right(
        PayrollDetailsModel(payroll: payroll, employeesPayroll: employeesPayroll),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> savePayroll({
    required PayrollDetailsModel payrollDetails,
  }) async {
    try {
      final payrollRef = firebaseService.fireStore
          .collection('payrolls')
          .doc(payrollDetails.payroll.id);
      await payrollRef.set(payrollDetails.payroll.toJson());

      final batch = firebaseService.fireStore.batch();
      for (var emp in payrollDetails.employeesPayroll) {
        final empRef = payrollRef.collection('employeesPayroll').doc(emp.employeeId);
        batch.set(empRef, emp.toJson());
      }
      await batch.commit();

      return const Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> payrollCalculator({
    required List<EmployeeModel> employeesList,
    required List<AttendanceRecordModel> attendanceRecord,
  }) {
    // TODO: implement payrollCalculator
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updateEmployee({required EmployeeModel employee}) async {
    try {
      await firebaseService.updateData(
        collection: "employees",
        docId: employee.id,
        data: employee.toJson(),
      );
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }
}
