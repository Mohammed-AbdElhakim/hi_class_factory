// import 'dart:convert';
//
// import '../../features/auth/data/models/user_model.dart';
// import '../helper/SharedPreferences/pref.dart';
// import 'app_strings.dart';
//
// class AppData {
//   static UserModel? currentUser;
//
//   static Future<void> loadUser() async {
//     String? userJson = await Pref.getStringFromPref(key: AppStrings.currentUser);
//
//     if (userJson != null) {
//       Map<String, dynamic> userMap = jsonDecode(userJson);
//       currentUser = UserModel.fromJson(userMap);
//     }
//   }
//
//   static Future<void> saveUser(UserModel userModel) async {
//     currentUser = userModel;
//     await Pref.saveStringToPref(
//       key: AppStrings.currentUser,
//       value: jsonEncode(userModel.toJson()),
//     );
//   }
//
//   static Future<void> logout() async {
//     currentUser = null;
//     await Pref.removeFromPref(key: AppStrings.currentUser);
//   }
// }
