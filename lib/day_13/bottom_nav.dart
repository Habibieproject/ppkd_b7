import 'package:bottom_navigator/bottom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:ppkd_b7/day_10/image.dart';
// Import PreferenceHandler & LoginDay17 dari Day 17 untuk fitur Logout & Navigasi Session
import 'package:ppkd_b7/day_17/service/preference_handler.dart';
import 'package:ppkd_b7/day_17/views/login_day_17.dart';
import 'package:ppkd_b7/day_6/expanded.dart';
import 'package:ppkd_b7/day_8/stack.dart';
import 'package:ppkd_b7/extension/navigator.dart';

// Widget utama BottomNavDay13 yang menampilkan navigasi bawah (FloatingNavBottomBar).
class BottomNavDay13 extends StatefulWidget {
  const BottomNavDay13({super.key});

  @override
  State<BottomNavDay13> createState() => _BottomNavDay13State();
}

class _BottomNavDay13State extends State<BottomNavDay13> {
  // Indeks item navigasi bawah yang sedang aktif.
  int _selectedBottom = 0;

  // Fungsi untuk mengubah item navigasi aktif.
  void changeBottom(int index) {
    _selectedBottom = index;
    print("Ini adalah value dari $_selectedBottom");
    setState(() {});
  }

  // Daftar halaman/widget yang ditampilkan pada body sesuai indeks terpilih.
  final List<Widget> _widgetOptions = [
    const ExpandedDay6(),
    const StackDay8(),
    const ShowImageDay10(),
    const LogoutScreen(), // Halaman logout (terhubung ke Day 17)
  ];

  // Daftar item menu yang muncul di navigasi bawah.
  List<BottomNavItem> navItems = [
    BottomNavItem(icon: Icons.home, label: "Home"),
    BottomNavItem(icon: Icons.school, label: "School"),
    BottomNavItem(icon: Icons.business, label: "Business"),
    BottomNavItem(icon: Icons.logout, label: "Logout"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: FloatingNavBottomBar(
        showLabels: true,
        backgroundColor: Colors.blue,
        items: navItems,
        currentIndex: _selectedBottom,
        onTap: (index) => setState(() => _selectedBottom = index),
      ),
      // Menampilkan widget yang sesuai dengan indeks _selectedBottom
      body: _widgetOptions.elementAt(_selectedBottom),
    );
  }
}

// Widget LogoutScreen yang berfungsi menangani proses logout pengguna.
class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // 1. Menghapus session status login di SharedPreferences lokal.
        PreferenceHandler.logOut();

        // 2. Mengarahkan pengguna kembali ke halaman LoginDay17 serta menghapus seluruh tumpukan navigasi sebelumnya (pushAndRemoveAll).
        context.pushAndRemoveAll(const LoginDay17());
      },
      child: const Center(
        child: Icon(Icons.logout, size: 48),
      ),
    );
  }
}

