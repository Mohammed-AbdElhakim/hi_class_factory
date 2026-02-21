part of 'invoices_cubit.dart';

sealed class InvoicesState extends Equatable {
  const InvoicesState();
  @override
  List<Object> get props => [];
}

final class InvoicesInitial extends InvoicesState {}

final class InvoicesLoading extends InvoicesState {}

final class InvoicesError extends InvoicesState {
  final String message;

  const InvoicesError({required this.message});
}

final class InvoicesSuccess extends InvoicesState {
  final List<ProductModel> productsList;

  const InvoicesSuccess({required this.productsList});
}
