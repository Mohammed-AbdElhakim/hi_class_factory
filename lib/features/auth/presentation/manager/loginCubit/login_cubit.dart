import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi_class_factory/core/constants/app_strings.dart';
import 'package:hi_class_factory/core/extensions/context_navigator_x_extensions.dart';
import 'package:hi_class_factory/core/extensions/either_extensions.dart';
import 'package:hi_class_factory/my_home_page.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/helper/SharedPreferences/pref.dart';
import '../../../data/models/login_model.dart';
import '../../../data/repositories/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepo) : super(LoginInitial());

  final LoginRepo loginRepo;
  Future<void> loginUser({
    required String username,
    required String password,
    required BuildContext context,
  }) async {
    emit(LoginLoading());
    Either<Failure, LoginModel> result = await loginRepo.loginUser(
      username: username,
      password: password,
    );
    result.handleWithCubit(
      onSuccess: (data) {
        emit(LoginSuccess(data));
        Pref.saveBoolToPref(key: AppStrings.isLoginKey, value: true);
        context.pushReplacementPage(page: MyHomePage());
      },
      onError: (message) {
        emit(LoginFailure(message));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      },
    );
  }
}
