import 'package:flutter/material.dart';

/// Class [LayoutingDay6] mendemonstrasikan konsep dasar tata letak (layouting) di Flutter,
/// seperti penggunaan [SizedBox], [Padding], [Row], [Column], dan pewarnaan.
class LayoutingDay6 extends StatelessWidget {
  const LayoutingDay6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Pengaturan warna latar belakang AppBar dengan berbagai opsi format:
        backgroundColor:
            // 1. Menggunakan warna dasar bawaan material design:
            // Colors.red,
            
            // 2. Menggunakan nilai Alpha, Red, Green, Blue (ARGB):
            // const Color.fromARGB(255, 117, 102, 101),
            
            // 3. Menggunakan nilai Hexadecimal (0xff didepan nilai Hex):
            Color(0xff90B800),

        title: Text("Layouting Day 6"),
        centerTitle: true,
      ),
      body: Column(
        // Menentukan perataan silang (cross axis alignment).
        // Untuk Column, cross axis-nya adalah horizontal (kiri-kanan).
        crossAxisAlignment: CrossAxisAlignment.start, // Meratakan anak-anaknya di sisi kiri layar
        children: [
          // ==============================
          // PENGGUNAAN SIZEDBOX
          // ==============================
          Text("Hello Batch 7"),
          SizedBox(height: 40), // Berfungsi sebagai spacer vertikal setinggi 40 pixel
          Text("Hello Batch 7"),
          SizedBox(height: 20), // Spacer vertikal setinggi 20 pixel

          Text("Hello Batch 7"),
          Row(
            children: [
              Icon(Icons.star),
              SizedBox(width: 20), // Berfungsi sebagai spacer horizontal selebar 20 pixel di dalam Row
              Text("Hello Batch 7"),
            ],
          ),
          Row(children: [Icon(Icons.star), Text("Hello Batch 7")]),
          
          // SizedBox juga bisa membungkus widget lain untuk membatasi dimensi tingginya
          SizedBox(
            height: 50, // Memaksa Row di dalamnya memiliki tinggi maksimum 50 pixel
            child: Row(children: [Icon(Icons.star), Text("Hello Batch 7")]),
          ),
          Row(children: [Icon(Icons.star), Text("Dibawah ini Padding")]),

          // ==============================
          // PENGGUNAAN PADDING
          // ==============================
          
          // Padding dengan jarak di semua sisi (EdgeInsets.all)
          Padding(
            padding: const EdgeInsets.all(16.0), // Jarak 16 pixel di atas, bawah, kiri, dan kanan
            child: Row(
              children: [
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
              ],
            ),
          ),

          // Padding hanya di sisi tertentu (EdgeInsets.only)
          Padding(
            padding: const EdgeInsets.only(left: 24), // Hanya memberikan jarak 24 pixel di sisi kiri
            child: Row(
              children: [
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

