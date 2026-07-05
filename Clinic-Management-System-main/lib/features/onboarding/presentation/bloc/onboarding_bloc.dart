import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';
part 'onboarding_bloc.freezed.dart';

@injectable
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(const OnboardingState.initial()) {
    on<_Complete>((event, emit) async {
      emit(const OnboardingState.loading());
      // TODO: Call CompleteOnboardingUsecase to save completion state
      await Future.delayed(const Duration(milliseconds: 500));
      emit(const OnboardingState.completed());
    });
  }
}
