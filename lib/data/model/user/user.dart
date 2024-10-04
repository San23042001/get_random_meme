

import 'package:get_random_memes/constants/hive_constants.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';
@JsonSerializable()
@HiveType(typeId:HiveTypeIds.userTypeId)
class User extends HiveObject{
  @HiveField(0)
  final String? userName;
  @HiveField(1)
  final String? email;
  @HiveField(2)
  final String? profilePictureUrl;
  @HiveField(3)
  final String? mobileNumber;


  User({
    required this.userName,
    required this.email,
    required this.profilePictureUrl,
    required this.mobileNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? userName,
    String? email,
    String? profilePictureUrl,
    String? mobileNumber,
  }) =>
      User(
        userName: userName ?? this.userName,
        email: email ?? this.email,
        profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
        mobileNumber: mobileNumber ?? this.mobileNumber,
      );
}