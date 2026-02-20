part of 'fabric_stock_cubit.dart';

sealed class FabricStockState extends Equatable {
  const FabricStockState();
  @override
  List<Object?> get props => [];
}

final class FabricStockInitial extends FabricStockState {}

final class FabricStockLoading extends FabricStockState {}

final class FabricStockError extends FabricStockState {
  final String message;

  const FabricStockError(this.message);

  @override
  List<Object?> get props => [message];
}

final class FabricStockSuccess extends FabricStockState {
  final List<FabricStockModel> fabricStockList;

  const FabricStockSuccess(this.fabricStockList);

  @override
  List<Object?> get props => [fabricStockList];
}
