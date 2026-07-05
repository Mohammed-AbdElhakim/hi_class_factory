import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/profile.dart';

part 'profile_response_model.g.dart';

@JsonSerializable()
class ProfileResponseModel {
  final String uid;
  final String fullName;
  final String email;
  final String? profileImageUrl;

  ProfileResponseModel({
    required this.uid,
    required this.fullName,
    required this.email,
    this.profileImageUrl,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseModelToJson(this);

  Profile toDomain() => Profile(
        uid: uid,
        fullName: fullName,
        email: email,
        profileImageUrl: profileImageUrl,
      );
}

extension ProfileResponseModelX on ProfileResponseModel {
  Profile toDomain() => Profile(
        uid: uid,
        fullName: fullName,
        email: email,
        profileImageUrl: profileImageUrl,
      );
}
