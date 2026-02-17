part of 'finished_products_cubit.dart';

sealed class FinishedProductsState extends Equatable {
  const FinishedProductsState();
  @override
  List<Object?> get props => [];
}

final class FinishedProductsInitial extends FinishedProductsState {}

final class FinishedProductsLoading extends FinishedProductsState {}

final class FinishedProductsError extends FinishedProductsState {
  final String message;

  const FinishedProductsError(this.message);

  @override
  List<Object?> get props => [message];
}

final class FinishedProductsSuccess extends FinishedProductsState {
  final List<ProductModel> products;

  const FinishedProductsSuccess(this.products);

  @override
  List<Object?> get props => [products];
}
