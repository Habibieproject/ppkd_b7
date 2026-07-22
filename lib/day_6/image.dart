import 'package:flutter/material.dart';

/// Class [ImageContainerDay6] mendemonstrasikan cara menampilkan gambar lokal (Asset Image)
/// di dalam dekorasi widget [Container] menggunakan [DecorationImage] dan [AssetImage].
class ImageContainerDay6 extends StatelessWidget {
  const ImageContainerDay6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Container day 6"),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          // Container yang didekorasi untuk menampilkan gambar latar belakang
          Container(
            height: 300,
            width: 200,
            decoration: BoxDecoration(
              // image properti dari BoxDecoration menerima objek DecorationImage
              image: DecorationImage(
                // AssetImage digunakan untuk memuat gambar dari aset proyek lokal.
                // Catatan Penting: Path gambar ini harus didaftarkan terlebih dahulu di file 'pubspec.yaml'
                // di bawah bagian 'flutter:' -> 'assets:'.
                image: AssetImage("assets/images/Dragon_Ball.jpg"),
                // Anda juga dapat menambahkan properti fit (seperti BoxFit.cover) untuk menyesuaikan skala gambar
              ),
            ),
          ),
        ],
      ),
    );
  }
}

