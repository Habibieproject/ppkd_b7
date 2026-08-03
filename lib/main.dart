import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ppkd_b7/day_11/home.dart';
import 'package:ppkd_b7/day_13/login.dart';

// Fungsi main merupakan entry point utama dari aplikasi Flutter.
// async digunakan karena kita perlu menunggu (await) inisialisasi formatting tanggal.
void main() async {
  // Inisialisasi lokalisasi tanggal untuk format Indonesia (id_ID) agar DateFormat dapat menggunakan format lokal.
  await initializeDateFormatting("id_ID,", null);
  runApp(const MyApp());
}

// Widget utama aplikasi yang bersifat Stateless (tidak memiliki state internal yang berubah).
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Menyembunyikan banner "DEBUG" di pojok kanan atas layar.
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // Mengatur tema global aplikasi.
      theme: ThemeData(
        // Menentukan skema warna dasar yang dihasilkan dari warna ungu (deepPurple).
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // Rute awal yang akan ditampilkan pertama kali saat aplikasi dibuka.
      initialRoute: "/",
      // Definisi rute navigasi aplikasi (Push Named Routing).
      routes: {
        // Halaman login day 13 sebagai rute default (/).
        "/": (context) => LoginDay13ByAdul(),
        // Halaman utama day 11 (/home).
        "/home": (context) => HomeRoutingDay11(),
      },
    );
  }
}
