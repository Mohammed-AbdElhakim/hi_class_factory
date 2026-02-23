part of 'report_cubit.dart';

sealed class ReportState extends Equatable {
  const ReportState();
  @override
  List<Object?> get props => [];
}

final class ReportInitial extends ReportState {}

final class ReportLoading extends ReportState {}

final class ReportError extends ReportState {
  final String message;

  const ReportError(this.message);

  @override
  List<Object?> get props => [message];
}

final class ReportSuccess extends ReportState {
  final List<InvoiceModel> invoiceList;

  const ReportSuccess(this.invoiceList);

  @override
  List<Object?> get props => [invoiceList];
}
