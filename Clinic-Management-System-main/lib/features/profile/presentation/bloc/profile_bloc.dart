import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/profile.dart';
import '../../domain/usecases/get_profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUsecase _getProfileUsecase;

  ProfileBloc(this._getProfileUsecase) : super(const ProfileState.initial()) {
    on<_FetchProfile>((event, emit) async {
      emit(const ProfileState.loading());
      try {
        final profile = await _getProfileUsecase.execute();
        emit(ProfileState.loaded(profile));
      } catch (e) {
        emit(ProfileState.error(e.toString()));
      }
    });
  }
}
