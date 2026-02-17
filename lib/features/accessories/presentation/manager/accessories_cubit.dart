import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/accessories_model.dart';
import '../../data/repositories/accessories_repo.dart';

part 'accessories_state.dart';

class AccessoriesCubit extends Cubit<AccessoriesState> {
  AccessoriesCubit(this.repo) : super(AccessoriesInitial());
  final AccessoriesRepo repo;

  Future<void> getAccessories() async {
    emit(AccessoriesLoading());

    final result = await repo.getAccessories();

    result.fold(
      (failure) => emit(AccessoriesError(failure.errorMessage)),
      (accessories) => emit(AccessoriesSuccess(accessories)),
    );
  }

  Future<void> addAccessories(AccessoriesModel accessory) async {
    emit(AccessoriesLoading());

    final result = await repo.addAccessories(accessory: accessory);

    result.fold((failure) => emit(AccessoriesError(failure.errorMessage)), (_) {
      if (state is AccessoriesSuccess) {
        final currentProducts = (state as AccessoriesSuccess).accessories;
        final updatedProducts = List<AccessoriesModel>.from(currentProducts)
          ..add(accessory);
        emit(AccessoriesSuccess(updatedProducts));
      } else {
        getAccessories();
      }
    });
  }

  Future<void> deleteAccessories(String id) async {
    emit(AccessoriesLoading());

    final result = await repo.deleteAccessories(id: id);

    result.fold((failure) => emit(AccessoriesError(failure.errorMessage)), (_) {
      if (state is AccessoriesSuccess) {
        final currentProducts = (state as AccessoriesSuccess).accessories;
        final updatedProducts = currentProducts.where((p) => p.id != id).toList();
        emit(AccessoriesSuccess(updatedProducts));
      } else {
        getAccessories();
      }
    });
  }

  Future<void> updateAccessories(AccessoriesModel accessory) async {
    emit(AccessoriesLoading());

    final result = await repo.updateAccessories(accessory: accessory);

    result.fold((failure) => emit(AccessoriesError(failure.errorMessage)), (_) {
      if (state is AccessoriesSuccess) {
        final currentProducts = (state as AccessoriesSuccess).accessories;
        final updatedProducts = currentProducts.map((p) {
          return p.id == accessory.id ? accessory : p;
        }).toList();
        emit(AccessoriesSuccess(updatedProducts));
      } else {
        getAccessories();
      }
    });
  }
}
