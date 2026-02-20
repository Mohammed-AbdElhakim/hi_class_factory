import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/fabric_stock_model.dart';
import '../../../data/repositories/fabric_stock/fabric_stock_repo.dart';

part 'fabric_stock_state.dart';

class FabricStockCubit extends Cubit<FabricStockState> {
  FabricStockCubit(this.repo) : super(FabricStockInitial());
  final FabricStockRepo repo;

  Future<void> getFabricStock() async {
    emit(FabricStockLoading());

    final result = await repo.getFabricStock();

    result.fold(
      (failure) => emit(FabricStockError(failure.errorMessage)),
      (accessories) => emit(FabricStockSuccess(accessories)),
    );
  }

  Future<void> addFabricStock(FabricStockModel fabricStockModel) async {
    emit(FabricStockLoading());

    final result = await repo.addFabricStock(fabricStockModel: fabricStockModel);

    result.fold((failure) => emit(FabricStockError(failure.errorMessage)), (_) {
      if (state is FabricStockSuccess) {
        final currentProducts = (state as FabricStockSuccess).fabricStockList;
        final updatedProducts = List<FabricStockModel>.from(currentProducts)
          ..add(fabricStockModel);
        emit(FabricStockSuccess(updatedProducts));
      } else {
        getFabricStock();
      }
    });
  }

  Future<void> deleteFabricStock(String id) async {
    emit(FabricStockLoading());

    final result = await repo.deleteFabricStock(id: id);

    result.fold((failure) => emit(FabricStockError(failure.errorMessage)), (_) {
      if (state is FabricStockSuccess) {
        final currentProducts = (state as FabricStockSuccess).fabricStockList;
        final updatedProducts = currentProducts.where((p) => p.id != id).toList();
        emit(FabricStockSuccess(updatedProducts));
      } else {
        getFabricStock();
      }
    });
  }

  Future<void> updateFabricStock(FabricStockModel fabricStockModel) async {
    emit(FabricStockLoading());

    final result = await repo.updateFabricStock(fabricStockModel: fabricStockModel);

    result.fold((failure) => emit(FabricStockError(failure.errorMessage)), (_) {
      if (state is FabricStockSuccess) {
        final currentProducts = (state as FabricStockSuccess).fabricStockList;
        final updatedProducts = currentProducts.map((p) {
          return p.id == fabricStockModel.id ? fabricStockModel : p;
        }).toList();
        emit(FabricStockSuccess(updatedProducts));
      } else {
        getFabricStock();
      }
    });
  }
}
