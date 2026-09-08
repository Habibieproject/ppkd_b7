import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ppkd_b7/day_11/home.dart';
import 'package:ppkd_b7/day_17/service/preference_handler.dart';
import 'package:ppkd_b7/day_20/constants/app_theme.dart';
import 'package:ppkd_b7/day_20/views/register_toefl_page.dart';
import 'package:ppkd_b7/day_23/views/login_day_23.dart';
import 'package:ppkd_b7/day_36/views/login_screen.dart';
import 'package:ppkd_b7/firebase_options.dart';

// Fungsi main merupakan entry point utama dari aplikasi Flutter.
// async digunakan karena kita perlu menunggu (await) inisialisasi async sebelum runApp dipanggil.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inisialisasi lokalisasi tanggal untuk format Indonesia (id_ID) agar DateFormat dapat menggunakan format lokal.
  await initializeDateFormatting("id_ID,", null);
  // Inisialisasi Firebase Core dengan opsi konfigurasi platform otomatis dari DefaultFirebaseOptions.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      theme: AppTheme.light,

      // ThemeData(
      //   // Menentukan skema warna dasar yang dihasilkan dari warna ungu (deepPurple).
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      // ),
      // Rute awal yang akan ditampilkan pertama kali saat aplikasi dibuka.
      initialRoute: "/",
      // Definisi rute navigasi aplikasi (Push Named Routing).
      routes: {
        // Halaman Login Firebase Day 36 sebagai rute utama (/).
        "/": (context) => LoginScreenDay36(),
        "/login_day_23": (context) => const LoginDay23(),
        "/toefl_register": (context) => const RegisterToeflPage(),
        // Halaman utama day 11 (/home).
        "/home": (context) => HomeRoutingDay11(),
      },
    );
  }
}
