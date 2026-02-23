import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/invoice_model.dart';
import '../../../data/repositories/invoices_repo_impl.dart';

part 'save_invoices_state.dart';

class SaveInvoicesCubit extends Cubit<SaveInvoicesState> {
  SaveInvoicesCubit(this.repo) : super(SaveInvoicesInitial());
  final InvoicesRepoImpl repo;
  Future<void> saveInvoice({required InvoiceModel invoice}) async {
    emit(SaveInvoicesLoading());

    final result = await repo.saveInvoice(invoice: invoice);

    result.fold(
      (failure) => emit(SaveInvoicesError(failure.errorMessage)),
      (invoice) => emit(SaveInvoicesSuccess(invoice: invoice)),
    );
  }
}
