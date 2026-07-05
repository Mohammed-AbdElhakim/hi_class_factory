import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'splash_event.dart';
part 'splash_state.dart';
part 'splash_bloc.freezed.dart';

@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState.initial()) {
    on<_Initialize>((event, emit) async {
      emit(const SplashState.loading());
      // Simulate auth check loading delay
      await Future.delayed(const Duration(seconds: 2));
      
      // TODO: Fetch from usecase to decide target destination
      emit(const SplashState.navToOnboarding());
    });
  }
}
