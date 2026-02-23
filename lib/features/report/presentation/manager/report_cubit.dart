import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../invoices/data/models/invoice_model.dart';
import '../../data/repositories/report_repo.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit(this.repo) : super(ReportInitial());
  final ReportRepo repo;

  Future<void> getReport() async {
    emit(ReportLoading());

    final result = await repo.getReport();

    result.fold(
      (failure) => emit(ReportError(failure.errorMessage)),
      (invoicesList) => emit(ReportSuccess(invoicesList)),
    );
  }

  Future<void> deleteReport(String id) async {
    emit(ReportLoading());

    final result = await repo.deleteReport(id: id);

    result.fold((failure) => emit(ReportError(failure.errorMessage)), (_) {
      if (state is ReportSuccess) {
        final currentProducts = (state as ReportSuccess).invoiceList;
        final updatedProducts = currentProducts.where((p) => p.id != id).toList();
        emit(ReportSuccess(updatedProducts));
      } else {
        getReport();
      }
    });
  }
}
