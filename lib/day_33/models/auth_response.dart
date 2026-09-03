// Day 33: Model Data AuthResponse menggunakan JsonSerializable
// Menggunakan package `json_annotation` untuk otomasi serialisasi JSON.

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

AuthResponse authResponseFromJson(String str) =>
    AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

@JsonSerializable()
class AuthResponse {
  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final Data? data;

  AuthResponse({
    this.message,
    this.data,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "token")
  final String? token;

  @JsonKey(name: "user")
  final User? user;

  Data({
    this.token,
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class User {
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

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}