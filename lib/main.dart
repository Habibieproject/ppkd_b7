import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ppkd_b7/day_11/home.dart';
import 'package:ppkd_b7/day_17/service/preference_handler.dart';
import 'package:ppkd_b7/day_17/views/splash_screen.dart';

// Fungsi main merupakan entry point utama dari aplikasi Flutter.
// async digunakan karena kita perlu menunggu (await) inisialisasi async sebelum runApp dipanggil.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inisialisasi lokalisasi tanggal untuk format Indonesia (id_ID) agar DateFormat dapat menggunakan format lokal.
  await initializeDateFormatting("id_ID,", null);
  
  // Inisialisasi SharedPreferences (Day 17) agar siap digunakan di seluruh aplikasi.
  await PreferenceHandler.init();

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
        // Halaman Splash Screen Day 17 sebagai rute default (/).
        // Halaman ini akan mengecek session login dan mengarahkan user ke LoginDay17 atau BottomNavDay13.
        "/": (context) => const SplashScreenDay17(),
        // Halaman utama day 11 (/home).
        "/home": (context) => HomeRoutingDay11(),
      },
    );
  }
}

