class UserModel {
  final String uid;
  final String username;
  final String role;
  final DateTime createdAt;
  final DateTime lastLogin;
  final DateTime lastLogout;
  final String factoryId;

  UserModel({
    required this.uid,
    required this.username,
    required this.role,
    required this.createdAt,
    required this.lastLogin,
    required this.lastLogout,
    required this.factoryId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      username: json['username'],
      role: json['role'],
      createdAt: DateTime.parse(json['createdAt']),
      lastLogin: DateTime.parse(json['lastLogin']),
      lastLogout: DateTime.parse(json['lastLogout']),
      factoryId: json['factoryId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
      'lastLogin': lastLogin.toIso8601String(),
      'lastLogout': lastLogout.toIso8601String(),
      'factoryId': factoryId,
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
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
      lastLogout: lastLogout ?? this.lastLogout,
      factoryId: factoryId ?? this.factoryId,
    );
  }
}
