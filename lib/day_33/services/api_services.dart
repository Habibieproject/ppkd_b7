// Day 33: Retrofit API Service Interface
// Memanfaatkan package Retrofit untuk mengelola HTTP Endpoint berdasarkan Postman Collection.

import 'package:dio/dio.dart';
import 'package:ppkd_b7/day_33/models/auth_response.dart';
import 'package:ppkd_b7/day_33/models/profile_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: 'https://absensib1.mobileprojp.com')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // Endpoint Registrasi Pengguna Baru
  @POST('/api/register')
  Future<AuthResponse> register(@Body() Map<String, dynamic> body);

  // Endpoint Login Pengguna
  @POST('/api/login')
  Future<AuthResponse> login(@Body() Map<String, dynamic> body);

  // Endpoint Mengambil Profile Pengguna
  @GET('/api/profile')
  Future<ProfileResponse> getProfile(
    @Header('Authorization') String token,
  );

  // Endpoint Mengubah Profile Pengguna
  @PUT('/api/profile')
  Future<ProfileResponse> updateProfile(
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> body,
  );
}
