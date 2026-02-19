part of 'bakr_cubit.dart';

sealed class BakrState extends Equatable {
  const BakrState();
  @override
  List<Object?> get props => [];
}

final class BakrInitial extends BakrState {}

final class BakrLoading extends BakrState {}

final class BakrError extends BakrState {
  final String message;

  const BakrError(this.message);

  @override
  List<Object?> get props => [message];
}

final class BakrSuccess extends BakrState {
  final List<BakrModel> bakr;

  const BakrSuccess(this.bakr);

  @override
  List<Object?> get props => [bakr];
}
