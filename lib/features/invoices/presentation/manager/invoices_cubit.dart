import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../finishedProducts/data/models/product_model.dart';
import '../../data/repositories/invoices_repo_impl.dart';

part 'invoices_state.dart';

class InvoicesCubit extends Cubit<InvoicesState> {
  InvoicesCubit(this.repo) : super(InvoicesInitial());
  final InvoicesRepoImpl repo;

  Future<void> getProducts() async {
    emit(InvoicesLoading());

    final result = await repo.getProducts();

    result.fold(
      (failure) => emit(InvoicesError(message: failure.errorMessage)),
      (products) => emit(InvoicesSuccess(productsList: products)),
    );
  }
}
