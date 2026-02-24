import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi_class_factory/core/constants/app_strings.dart';

import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../data/models/profile_model.dart';
import '../../data/repositories/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.repo) : super(ProfileInitial());
  final ProfileRepo repo;

  Future<void> getProfile() async {
    emit(ProfileLoading());

    final result = await repo.getProfile();

    result.fold(
      (failure) => emit(ProfileError(failure.errorMessage)),
      (profile) => emit(ProfileSuccess(profile)),
    );
  }

  Future<void> saveProfile(ProfileModel profile) async {
    emit(ProfileLoading());

    final result = await repo.saveProfile(profile: profile);

    result.fold((failure) => emit(ProfileError(failure.errorMessage)), (_) async {
      await Pref.saveStringToPref(
        key: AppStrings.profileDataKey,
        value: jsonEncode(profile.toJson()),
      );
      emit(ProfileSuccess(profile));
    });
  }
}
