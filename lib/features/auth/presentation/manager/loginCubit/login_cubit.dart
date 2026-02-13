import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi_class_factory/features/auth/data/repositories/login_repo.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/helper/SharedPreferences/pref.dart';
import '../../../data/models/user_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepo) : super(LoginInitial());
  bool isEmployee = true;
  final LoginRepo loginRepo;
  void toggleRole(bool value) {
    isEmployee = value;
    emit(LoginRoleChanged(isEmployee));
  }

  Future<void> loginUser({
    required String username,
    required String password,
    required BuildContext context,
  }) async {
    emit(LoginLoading());
    Either<Failure, UserModel> result = await loginRepo.loginUser(
      username: username,
      password: password,
    );

    result.fold(
      (failure) {
        emit(LoginFailure(failure.errorMessage));
      },
      (data) {
        emit(LoginSuccess(data));
        Pref.saveBoolToPref(key: AppStrings.isLoginKey, value: true);
      },
    );
  }
}
