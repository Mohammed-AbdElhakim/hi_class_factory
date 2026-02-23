part of 'save_invoices_cubit.dart';

sealed class SaveInvoicesState extends Equatable {
  const SaveInvoicesState();
  @override
  List<Object> get props => [];
}

final class SaveInvoicesInitial extends SaveInvoicesState {}

final class SaveInvoicesLoading extends SaveInvoicesState {}

final class SaveInvoicesError extends SaveInvoicesState {
  final String message;

  const SaveInvoicesError(this.message);
}

final class SaveInvoicesSuccess extends SaveInvoicesState {
  final InvoiceModel invoice;

  const SaveInvoicesSuccess({required this.invoice});
}
