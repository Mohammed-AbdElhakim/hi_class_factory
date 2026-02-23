part of 'invoices_product_cubit.dart';

sealed class InvoicesProductState extends Equatable {
  const InvoicesProductState();
  @override
  List<Object> get props => [];
}

final class InvoicesProductInitial extends InvoicesProductState {}

final class InvoicesProductLoading extends InvoicesProductState {}

final class InvoicesProductError extends InvoicesProductState {
  final String message;

  const InvoicesProductError({required this.message});
}

final class InvoicesProductSuccess extends InvoicesProductState {
  final List<ProductModel> productsList;

  const InvoicesProductSuccess({required this.productsList});
}
