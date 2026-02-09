// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:hi_class_factory/core/firebase/firebase_service.dart';
//
// import 'core/constants/app_router.dart';
// import 'core/constants/app_strings.dart';
// import 'core/helper/SharedPreferences/pref.dart';
//
// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: InkWell(
//           onTap: () async {
//             final user = FirebaseService().currentUser;
//             if (user != null) {
//               final now = Timestamp.now();
//               await FirebaseService().updateData(
//                 collection: AppStrings.collectionUsers,
//                 docId: user.uid,
//                 data: {'lastLogout': now},
//               );
//               await Pref.saveBoolToPref(key: AppStrings.isLoginKey, value: false);
//               await FirebaseService().logout();
//               AppRouter.pushReplacement(AppRouter.kLoginView);
//             }
//           },
//           child: Text("${FirebaseService().currentUser!.email}"),
//         ),
//       ),
//     );
//   }
// }
