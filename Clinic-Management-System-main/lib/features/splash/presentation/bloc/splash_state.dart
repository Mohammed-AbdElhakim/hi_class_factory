part of 'splash_bloc.dart';

@freezed
class SplashState with _$SplashState {
  const factory SplashState.initial() = _Initial;
  const factory SplashState.loading() = _Loading;
  const factory SplashState.navToOnboarding() = _NavToOnboarding;
  const factory SplashState.navToAuth() = _NavToAuth;
  const factory SplashState.navToHome() = _NavToHome;
}
