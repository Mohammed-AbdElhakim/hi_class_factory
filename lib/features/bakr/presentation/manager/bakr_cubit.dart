import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/bakr_model.dart';
import '../../data/repositories/bakr_repo.dart';

part 'bakr_state.dart';

class BakrCubit extends Cubit<BakrState> {
  BakrCubit(this.repo) : super(BakrInitial());
  final BakrRepo repo;

  Future<void> getBakr() async {
    emit(BakrLoading());

    final result = await repo.getBakr();

    result.fold(
      (failure) => emit(BakrError(failure.errorMessage)),
      (bakr) => emit(BakrSuccess(bakr)),
    );
  }

  Future<void> addBakr(BakrModel bakr) async {
    emit(BakrLoading());

    final result = await repo.addBakr(bakr: bakr);

    result.fold((failure) => emit(BakrError(failure.errorMessage)), (_) {
      if (state is BakrSuccess) {
        final currentProducts = (state as BakrSuccess).bakr;
        final updatedProducts = List<BakrModel>.from(currentProducts)..add(bakr);
        emit(BakrSuccess(updatedProducts));
      } else {
        getBakr();
      }
    });
  }

  Future<void> deleteBakr(String id) async {
    emit(BakrLoading());

    final result = await repo.deleteBakr(id: id);

    result.fold((failure) => emit(BakrError(failure.errorMessage)), (_) {
      if (state is BakrSuccess) {
        final currentProducts = (state as BakrSuccess).bakr;
        final updatedProducts = currentProducts.where((p) => p.id != id).toList();
        emit(BakrSuccess(updatedProducts));
      } else {
        getBakr();
      }
    });
  }

  Future<void> updateBakr(BakrModel bakr) async {
    emit(BakrLoading());

    final result = await repo.updateBakr(bakr: bakr);

    result.fold((failure) => emit(BakrError(failure.errorMessage)), (_) {
      if (state is BakrSuccess) {
        final currentProducts = (state as BakrSuccess).bakr;
        final updatedProducts = currentProducts.map((p) {
          return p.id == bakr.id ? bakr : p;
        }).toList();
        emit(BakrSuccess(updatedProducts));
      } else {
        getBakr();
      }
    });
  }
}
