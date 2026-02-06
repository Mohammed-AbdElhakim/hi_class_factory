import 'package:firebase_auth/firebase_auth.dart';

class LoginModel {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;

  LoginModel({required this.uid, this.email, this.displayName, this.photoUrl});

  // تحويل من Firebase User
  factory LoginModel.fromFirebaseUser(User user) {
    return LoginModel(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }
}
