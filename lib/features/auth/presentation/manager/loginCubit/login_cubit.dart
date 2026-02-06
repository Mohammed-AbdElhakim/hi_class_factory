import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi_class_factory/core/extensions/either_extensions.dart';

import '../../../../../core/errors/failure.dart';
import '../../../data/models/login_model.dart';
import '../../../data/repositories/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepo) : super(LoginInitial());

  final LoginRepo loginRepo;
  Future<void> loginUser({required String username, required String password}) async {
    emit(LoginLoading());
    Either<Failure, LoginModel> result = await loginRepo.loginUser(
      username: username,
      password: password,
    );
    result.handleWithCubit(
      onSuccess: (data) {
        emit(LoginSuccess(data));
      },
      onError: (message) {
        emit(LoginFailure(message));
      },
    );
  }
}
