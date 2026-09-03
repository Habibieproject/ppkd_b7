// Day 33: Model Data ProfileResponse menggunakan JsonSerializable
// Menggunakan package `json_annotation` untuk otomasi serialisasi JSON.

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'profile_response.g.dart';

ProfileResponse profileResponseFromJson(String str) =>
    ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ProfileResponse {
  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final ProfileData? data;

  ProfileResponse({
    this.message,
    this.data,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}

@JsonSerializable()
class ProfileData {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "email")
  final String? email;

  @JsonKey(name: "email_verified_at")
  final String? emailVerifiedAt;

  @JsonKey(name: "created_at")
  final String? createdAt;

  @JsonKey(name: "updated_at")
  final String? updatedAt;

  ProfileData({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDataToJson(this);
}