class Profile {
  final String uid;
  final String fullName;
  final String email;
  final String? profileImageUrl;

  const Profile({
    required this.uid,
    required this.fullName,
    required this.email,
    this.profileImageUrl,
  });
}
