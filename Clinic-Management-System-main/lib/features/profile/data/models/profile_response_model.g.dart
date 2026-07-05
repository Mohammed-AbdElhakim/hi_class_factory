// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponseModel _$ProfileResponseModelFromJson(
        Map<String, dynamic> json) =>
    ProfileResponseModel(
      uid: json['uid'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
    );

Map<String, dynamic> _$ProfileResponseModelToJson(
        ProfileResponseModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'fullName': instance.fullName,
      'email': instance.email,
      'profileImageUrl': instance.profileImageUrl,
    };
