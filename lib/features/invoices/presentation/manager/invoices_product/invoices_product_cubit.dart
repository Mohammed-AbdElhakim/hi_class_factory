import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../finishedProducts/data/models/product_model.dart';
import '../../../data/repositories/invoices_repo_impl.dart';

part 'invoices_product_state.dart';

class InvoicesProductCubit extends Cubit<InvoicesProductState> {
  InvoicesProductCubit(this.repo) : super(InvoicesProductInitial());
  final InvoicesRepoImpl repo;

  Future<void> getProducts() async {
    emit(InvoicesProductLoading());

    final result = await repo.getProducts();

    result.fold(
      (failure) => emit(InvoicesProductError(message: failure.errorMessage)),
      (products) => emit(InvoicesProductSuccess(productsList: products)),
    );
  }
}
