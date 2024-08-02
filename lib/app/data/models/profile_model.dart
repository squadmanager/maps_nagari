// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  bool status;
  String message;
  DataProfileModel data;

  ProfileModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        status: json["status"],
        message: json["message"],
        data: DataProfileModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class DataProfileModel {
  int userId;
  String userName;
  String fullName;
  String email;
  String role;
  int status;
  dynamic colour;
  dynamic type;
  dynamic emailVerifiedAt;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deviceToken;
  dynamic GPSGroup;

  DataProfileModel({
    required this.userId,
    required this.userName,
    required this.fullName,
    required this.email,
    required this.role,
    required this.status,
    required this.colour,
    required this.type,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.deviceToken,
    required this.GPSGroup,
  });

  factory DataProfileModel.fromJson(Map<String, dynamic> json) =>
      DataProfileModel(
        userId: json["user_id"],
        userName: json["user_name"],
        fullName: json["full_name"],
        email: json["email"],
        role: json["role"],
        status: json["status"],
        colour: json["colour"],
        type: json["type"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : json["created_at"],
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : json["updated_at"],
        deviceToken: json["device_token"],
        GPSGroup: json["GPSGroup"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
        "full_name": fullName,
        "email": email,
        "role": role,
        "status": status,
        "colour": colour,
        "type": type,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "device_token": deviceToken,
        "GPSGroup": GPSGroup,
      };
}
