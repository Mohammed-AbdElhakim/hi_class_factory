import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/product_model.dart';
import '../../data/repositories/finished_products_repo.dart';

part 'finished_products_state.dart';

class FinishedProductsCubit extends Cubit<FinishedProductsState> {
  FinishedProductsCubit(this.repo) : super(FinishedProductsInitial());
  final FinishedProductsRepo repo;

  Future<void> getFinishedProducts() async {
    emit(FinishedProductsLoading());

    final result = await repo.getFinishedProducts();

    result.fold(
      (failure) => emit(FinishedProductsError(failure.errorMessage)),
      (products) => emit(FinishedProductsSuccess(products)),
    );
  }

  Future<void> addFinishedProduct(ProductModel product) async {
    emit(FinishedProductsLoading());

    final result = await repo.addFinishedProduct(product: product);

    result.fold((failure) => emit(FinishedProductsError(failure.errorMessage)), (_) {
      if (state is FinishedProductsSuccess) {
        final currentProducts = (state as FinishedProductsSuccess).products;
        final updatedProducts = List<ProductModel>.from(currentProducts)..add(product);
        emit(FinishedProductsSuccess(updatedProducts));
      } else {
        getFinishedProducts();
      }
    });
  }

  Future<void> deleteFinishedProduct(String id) async {
    emit(FinishedProductsLoading());

    final result = await repo.deleteFinishedProduct(id: id);

    result.fold((failure) => emit(FinishedProductsError(failure.errorMessage)), (_) {
      if (state is FinishedProductsSuccess) {
        final currentProducts = (state as FinishedProductsSuccess).products;
        final updatedProducts = currentProducts.where((p) => p.id != id).toList();
        emit(FinishedProductsSuccess(updatedProducts));
      } else {
        getFinishedProducts();
      }
    });
  }

  Future<void> updateFinishedProduct(ProductModel product) async {
    emit(FinishedProductsLoading());

    final result = await repo.updateFinishedProduct(product: product);

    result.fold((failure) => emit(FinishedProductsError(failure.errorMessage)), (_) {
      if (state is FinishedProductsSuccess) {
        final currentProducts = (state as FinishedProductsSuccess).products;
        final updatedProducts = currentProducts.map((p) {
          return p.id == product.id ? product : p;
        }).toList();
        emit(FinishedProductsSuccess(updatedProducts));
      } else {
        getFinishedProducts();
      }
    });
  }
}
