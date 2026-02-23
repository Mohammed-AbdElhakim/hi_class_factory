import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../invoices/data/models/invoice_model.dart';

abstract class ReportRepo {
  Future<Either<Failure, Unit>> deleteReport({required String id});

  Future<Either<Failure, List<InvoiceModel>>> getReport();
}
