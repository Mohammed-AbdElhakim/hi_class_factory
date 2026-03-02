import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hi_class_factory/core/errors/failure.dart';
import 'package:hi_class_factory/features/attendance/data/models/attendance_model.dart';

import '../../../../core/errors/failure_handler.dart';
import '../../../../core/errors/unknown_failure.dart';
import '../../../../core/firebase/firebase_service.dart';
import '../models/attendance_record_model.dart';
import 'attendance_repo.dart';

class AttendanceRepoImpl implements AttendanceRepo {
  final FirebaseService firebaseService;

  AttendanceRepoImpl(this.firebaseService);
  @override
  Future<Either<Failure, List<AttendanceModel>>> getAttendancePeriods() async {
    try {
      final snapshot = await firebaseService.fireStore
          .collection("attendance")
          .orderBy("fromDate", descending: true)
          .get();

      final periods = snapshot.docs
          .map((e) => AttendanceModel.fromJson(e.data()))
          .toList();

      return Right(periods);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return Left(UnknownFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AttendanceRecordModel>>> getAttendanceRecords({
    required String periodId,
  }) async {
    try {
      final snapshot = await firebaseService.fireStore
          .collection("attendance")
          .doc(periodId)
          .collection("records")
          .get();

      final records = snapshot.docs
          .map((e) => AttendanceRecordModel.fromJson(e.data()))
          .toList();

      return Right(records);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return Left(UnknownFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAttendancePeriod({required String periodId}) async {
    try {
      final periodRef = firebaseService.fireStore.collection("attendance").doc(periodId);

      // 1️⃣ جيب كل الـ records
      final recordsSnapshot = await periodRef.collection("records").get();

      // 2️⃣ Batch delete
      final batch = FirebaseFirestore.instance.batch();

      for (final doc in recordsSnapshot.docs) {
        batch.delete(doc.reference);
      }

      // 3️⃣ امسح الـ period نفسه
      batch.delete(periodRef);

      await batch.commit();

      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return Left(UnknownFailure(errorMessage: e.toString()));
    }
  }
}
