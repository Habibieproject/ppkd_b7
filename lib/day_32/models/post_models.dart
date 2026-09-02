// Day 32: Model Data menggunakan JsonSerializable
// File ini merepresentasikannya data JSON yang diterima dari API /posts.
// Menggunakan package `json_annotation` untuk otomasi serialisasi JSON.

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

// File generasi otomatis yang dibuat oleh build_runner
part 'post_models.g.dart';

// Helper function opsional untuk konversi JSON String ke List<PostModels>
List<PostModels> postModelsFromJson(String str) =>
    List<PostModels>.from(json.decode(str).map((x) => PostModels.fromJson(x)));

String postModelsToJson(List<PostModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// Annotation @JsonSerializable() memberi tahu build_runner untuk membuat fungsi fromJson dan toJson
@JsonSerializable()
class PostModels {
  // @JsonKey digunakan untuk memetakan nama field di JSON ke variabel di Dart
  @JsonKey(name: "userId")
  final int? userId;

  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "title")
  final String? title;

  @JsonKey(name: "body")
  final String? body;

  PostModels({this.userId, this.id, this.title, this.body});

  // Factory constructor dari JSON map ke objek PostModels
  factory PostModels.fromJson(Map<String, dynamic> json) =>
      _$PostModelsFromJson(json);

  // Method konversi dari objek PostModels ke JSON map
  Map<String, dynamic> toJson() => _$PostModelsToJson(this);
}

