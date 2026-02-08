import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String username;
  final String role;
  final DateTime? createdAt;
  final DateTime? lastLogin;
  final DateTime? lastLogout;
  final String factoryId;
  final String password;

  UserModel({
    required this.uid,
    required this.username,
    required this.role,
    required this.createdAt,
    required this.lastLogin,
    required this.lastLogout,
    required this.factoryId,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      username: json['username'],
      role: json['role'],
      lastLogin: json['lastLogin'] != null
          ? (json['lastLogin'] as Timestamp).toDate()
          : null,
      lastLogout: json['lastLogout'] != null
          ? (json['lastLogout'] as Timestamp).toDate()
          : null,
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as Timestamp).toDate()
          : null,

      factoryId: json['factoryId'],
      password: json['password'],
    );
  }

  //   // تحويل من Firebase User
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      username: '',
      role: '',
      createdAt: null,
      lastLogin: null,
      lastLogout: null,
      factoryId: '',
      password: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'role': role,
      'createdAt': createdAt?.toIso8601String(),
      'lastLogin': lastLogin?.toIso8601String(),
      'lastLogout': lastLogout?.toIso8601String(),
      'factoryId': factoryId,
      'password': password,
    };
  }

  UserModel copyWith({
    String? uid,
    String? username,
    String? role,
    DateTime? createdAt,
    DateTime? lastLogin,
    DateTime? lastLogout,
    String? factoryId,
    String? password,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
      lastLogout: lastLogout ?? this.lastLogout,
      factoryId: factoryId ?? this.factoryId,
      password: password ?? this.password,
    );
  }
}
