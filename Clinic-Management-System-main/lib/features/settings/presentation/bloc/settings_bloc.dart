import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/usecases/get_settings_usecase.dart';

part 'settings_event.dart';
part 'settings_state.dart';
part 'settings_bloc.freezed.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettingsUsecase _getSettingsUsecase;

  SettingsBloc(this._getSettingsUsecase) : super(const SettingsState.initial()) {
    on<_LoadSettings>((event, emit) async {
      emit(const SettingsState.loading());
      try {
        final settings = await _getSettingsUsecase.execute();
        emit(SettingsState.loaded(settings));
      } catch (e) {
        emit(SettingsState.error(e.toString()));
      }
    });
  }
}
