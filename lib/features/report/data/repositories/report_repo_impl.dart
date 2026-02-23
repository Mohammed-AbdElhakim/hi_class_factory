import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hi_class_factory/core/errors/failure.dart';

import '../../../../core/errors/failure_handler.dart';
import '../../../../core/errors/unknown_failure.dart';
import '../../../invoices/data/models/invoice_model.dart';
import 'report_repo.dart';

final String collectionName = "invoices";

class ReportRepoImpl implements ReportRepo {
  @override
  Future<Either<Failure, Unit>> deleteReport({required String id}) async {
    try {
      await FirebaseFirestore.instance.collection(collectionName).doc(id).delete();

      return right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<InvoiceModel>>> getReport() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection(collectionName).get();
      final invoices = snapshot.docs
          .map((doc) => InvoiceModel.fromJson(doc.data()))
          .toList();

      return right(invoices);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }
}
