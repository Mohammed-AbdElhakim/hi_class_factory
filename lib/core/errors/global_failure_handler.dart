import 'failure.dart';

class GlobalFailureHandler {
  static void handle({
    required Failure failure,
    required void Function(String message) onError,
  }) {
    if (failure.type == FailureType.unauthorized) {
      // مسح بيانات تسجيل الدخول
      // Pref.saveBoolToPref(key: AppStrings.isLoginKey, value: false);
      // Redirect للـ Login
      // AppRouter.pushReplacement(AppRouter.kLoginView);
    } else {
      // أي Error ثاني
      onError(failure.errorMessage);
    }
  }
}
