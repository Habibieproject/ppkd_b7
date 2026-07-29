import 'package:flutter/material.dart';
import 'package:ppkd_b7/day_11/home.dart';
import 'package:ppkd_b7/extension/navigator.dart';

/// [RoutingDay11] adalah widget halaman utama untuk materi Routing dan Navigasi pada Day 11.
/// Halaman ini mendemonstrasikan berbagai cara untuk berpindah halaman di Flutter menggunakan Navigator Extension.
class RoutingDay11 extends StatelessWidget {
  /// Konstruktor untuk [RoutingDay11].
  /// [super.key] digunakan untuk meneruskan key ke constructor superclass [StatelessWidget].
  const RoutingDay11({super.key});

  @override
  /// Method [build] berfungsi untuk menggambarkan struktur tampilan (UI) dari halaman ini.
  /// Method ini akan dijalankan ulang (rebuild) setiap kali Flutter perlu memperbarui tampilan.
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Routing Day 11"),
        backgroundColor: Colors.red,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                // context.push berasal dari extension navigator.dart.
                // Fungsi ini menambahkan (push) halaman HomeRoutingDay11 ke atas tumpukan (stack) navigasi saat ini.
                // Pengguna dapat kembali ke halaman ini dengan menekan tombol back atau Navigator.pop.
                context.push(HomeRoutingDay11());
              },
              child: Text("Push"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // context.pushNamed berasal dari extension navigator.dart.
                // Fungsi ini membuka halaman baru berdasarkan nama rute yang telah didaftarkan di MaterialApp (misalnya "/home").
                context.pushNamed("/home");
              },
              child: Text("PushNamed"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // context.pushReplacement berasal dari extension navigator.dart.
                // Fungsi ini menggantikan (replace) halaman saat ini dengan halaman HomeRoutingDay11.
                // Halaman saat ini akan dihapus dari tumpukan navigasi, sehingga jika pengguna menekan back,
                // mereka tidak akan kembali ke halaman ini melainkan ke halaman sebelumnya lagi.
                context.pushReplacement(HomeRoutingDay11());
              },
              child: Text("PushReplacement"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // context.pushAndRemoveAll berasal dari extension navigator.dart.
                // Fungsi ini membuka halaman HomeRoutingDay11 dan menghapus seluruh rute (halaman)
                // yang ada sebelumnya dari tumpukan navigasi, menjadikannya halaman pertama/satu-satunya di tumpukan.
                context.pushAndRemoveAll(HomeRoutingDay11());
              },
              child: Text("PushRemoveUntil"),
            ),
          ),
        ],
      ),
    );
  }
}

