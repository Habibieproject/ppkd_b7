// Day 32: Retrofit API Service Interface
// Memanfaatkan package Retrofit untuk mengelola HTTP Endpoint secara deklaratif.

import 'package:dio/dio.dart';
import 'package:ppkd_b7/day_32/models/post_models.dart';
import 'package:retrofit/retrofit.dart';

// File generasi otomatis retrofit_generator
part 'api_services.g.dart';

// @RestApi menentukan baseUrl default untuk seluruh endpoint di class ini
@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // Endpoint GET /posts untuk mengambil daftar semua data post
  @GET('/posts')
  Future<List<PostModels>> getAllPosts();
}

