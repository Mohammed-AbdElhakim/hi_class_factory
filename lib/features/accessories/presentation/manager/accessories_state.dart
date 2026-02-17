part of 'accessories_cubit.dart';

sealed class AccessoriesState extends Equatable {
  const AccessoriesState();
  @override
  List<Object?> get props => [];
}

final class AccessoriesInitial extends AccessoriesState {}

final class AccessoriesLoading extends AccessoriesState {}

final class AccessoriesError extends AccessoriesState {
  final String message;

  const AccessoriesError(this.message);

  @override
  List<Object?> get props => [message];
}

final class AccessoriesSuccess extends AccessoriesState {
  final List<AccessoriesModel> accessories;

  const AccessoriesSuccess(this.accessories);

  @override
  List<Object?> get props => [accessories];
}
