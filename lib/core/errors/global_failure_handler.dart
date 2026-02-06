import '../constants/app_strings.dart';
import '../helper/SharedPreferences/pref.dart';
import 'failure.dart';

class GlobalFailureHandler {
  static void handle({
    required Failure failure,
    required void Function(String message) onError,
  }) {
    if (failure.type == FailureType.unauthorized) {
      // مسح بيانات تسجيل الدخول
      Pref.saveBoolToPref(key: AppStrings.isLoginKey, value: false);
      // Redirect للـ Login
      // context.pushAndRemoveUntilPage(page: LoginView());
    } else {
      // أي Error ثاني
      onError(failure.errorMessage);
    }
  }
}
