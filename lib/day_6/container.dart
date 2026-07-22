import 'package:flutter/material.dart';

/// Class [ContainerDay6] menunjukkan berbagai variasi penggunaan widget [Container].
/// Container adalah widget serbaguna yang menggabungkan pengecatan dasar (painting),
/// pemosisian (positioning), dan penskalaan (sizing) widget anak.
class ContainerDay6 extends StatelessWidget {
  const ContainerDay6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Container day 6"),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // // 1. Contoh penggunaan Padding dan Container dasar (di-comment)
            // Padding(
            //   padding: const EdgeInsets.all(24.0),
            //   child: Container(height: 100, width: 400, color: Colors.red),
            // ),
            
            // 2. Baris berisi dua container berbeda: box teks dan lingkaran
            Row(
              children: [
                // Container pertama: Menampilkan data text di dalam kotak biru
                Container(
                  height: 100,
                  width: 200,
                  color: Colors.blue,
                  child: Column(
                    children: [
                      Text("Nama : Andrea"),
                      Text("Hoby : Mengajar"),
                      Text("Alamat : Indonesia Terci"),
                    ],
                  ),
                ),

                // Container kedua: Menampilkan lingkaran merah dengan angka di tengah
                Container(
                  height: 100,
                  width: 100,
                  alignment: Alignment.center, // Memposisikan child di tengah Container
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle, // Membuat bentuk lingkaran
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("1", style: TextStyle(fontSize: 20))],
                  ),
                ),
              ],
            ),
            
            // 3. Container dengan Margin, Padding, dan Warna Latar Belakang Hijau
            Container(
              margin: EdgeInsets.only(top: 20), // Jarak luar antara container dengan widget sekitarnya
              padding: EdgeInsets.all(16),      // Jarak dalam antara batas container dengan child-nya
              height: 100,
              width: 200,
              color: Colors.green,
              child: Column(
                children: [
                  Text("Nama : Andrea"),
                  Text("Hoby : Mengajar"),
                  Text("Alamat : Indonesia Terci"),
                ],
              ),
            ),
            
            // 4. Container menggunakan BoxDecoration untuk membuat Border dan BorderRadius
            // Catatan: Jika menggunakan `decoration`, warna `color` harus dipindahkan ke dalam `BoxDecoration`.
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(16),
              height: 100,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.green, // Warna latar dipindah ke sini karena memakai decoration
                // border memberikan garis pembatas di luar container
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                  strokeAlign: 10,
                ),
                // Berbagai opsi borderRadius untuk membuat sudut tumpul:
                // - BorderRadius.all(Radius.circular(20)) -> semua sudut tumpul
                // - BorderRadius.circular(20) -> jalan pintas semua sudut tumpul
                // - BorderRadius.only(...) -> sudut tertentu saja
                // - BorderRadius.horizontal(...) -> sudut kiri/kanan saja
                // - BorderRadius.vertical(...) -> sudut atas/bawah saja
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Hanya sudut atas yang tumpul
              ),
              child: Column(
                children: [
                  Text("Nama : Andrea"),
                  Text("Hoby : Mengajar"),
                  Text("Alamat : Indonesia Terci"),
                ],
              ),
            ),

            // 4 (Duplikat kedua). Container dengan tambahan efek Bayangan (boxShadow)
            Container(
              margin: EdgeInsets.only(top: 40),
              padding: EdgeInsets.all(16),
              height: 100,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                  strokeAlign: 10,
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                // boxShadow menerima list BoxShadow untuk memberikan efek bayangan/kedalaman (elevation)
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue,
                    blurRadius: 10,        // Seberapa pudar bayangannya
                    offset: Offset(10, 20), // Posisi bayangan (x = kanan, y = bawah)
                  ),
                  BoxShadow(
                    color: Colors.blue,
                    blurRadius: 10,
                    offset: Offset(-5, -10), // Posisi bayangan (x = kiri, y = atas)
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text("Nama : Andrea"),
                  Text("Hoby : Mengajar"),
                  Text("Alamat : Indonesia Terci"),
                ],
              ),
            ),

            // 5. Container dengan gradasi warna (gradient)
            Container(
              margin: EdgeInsets.only(top: 40),
              padding: EdgeInsets.all(16),
              height: 100,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                  strokeAlign: 10,
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                // Gradient untuk membuat warna transisi/gradasi.
                // Ada beberapa jenis:
                // - RadialGradient: Melingkar dari pusat
                // - SweepGradient: Memutar seperti jarum jam
                // - LinearGradient: Lurus dari satu sisi ke sisi lain
                gradient: LinearGradient(
                  colors: [Colors.yellow, Colors.red, Colors.blue], // Transisi Kuning -> Merah -> Biru
                ),
              ),
              child: Column(
                children: [
                  Text("Nama : Andrea"),
                  Text("Hoby : Mengajar"),
                  Text("Alamat : Indonesia Terci"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

