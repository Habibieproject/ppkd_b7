import 'dart:developer';

import 'package:flutter/material.dart';

// CounterDay10 adalah StatefulWidget karena memiliki data (state) 
// yang bisa berubah-ubah selama aplikasi berjalan (yaitu nilai counter).
class CounterDay10 extends StatefulWidget {
  const CounterDay10({super.key});

  @override
  State<CounterDay10> createState() => _CounterDay10State();
}

class _CounterDay10State extends State<CounterDay10> {
  // Variabel state untuk menyimpan nilai hitungan (counter)
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    // print() ini akan terpanggil setiap kali build dijalankan.
    // Ini membuktikan bahwa Flutter menggambar ulang layar saat setState() dipanggil.
    print("Baca disini gak ya?");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter Day 10"),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          // Row pertama untuk menampilkan nilai counter di tengah layar
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                counter.toString(), 
                style: const TextStyle(fontSize: 100),
              ),
            ],
          ),
          // Row kedua untuk menampung tombol-tombol aksi secara horizontal
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Tombol untuk mengurangi nilai counter
              ElevatedButton(
                onPressed: () {
                  // Memanggil setState() untuk memberitahu Flutter bahwa ada perubahan state
                  // dan UI perlu digambar ulang (rebuild).
                  setState(() {});
                  
                  // Mencetak nilai counter ke debug log sebelum dikurangi
                  log(counter.toString());
                  
                  // Mengurangi nilai counter
                  // Catatan pembelajaran: Best practice di Flutter adalah merubah nilai variabel 
                  // sebelum setState() atau di dalam callback setState(() { counter--; }) agar alur kode lebih rapi.
                  counter--;
                },
                child: const Text("Kurang"),
              ),
              // Tombol untuk mereset nilai counter kembali ke nol
              ElevatedButton(
                onPressed: () {
                  // Mengubah nilai counter terlebih dahulu menjadi 0
                  counter = 0;
                  // Kemudian memanggil setState() untuk menggambar ulang UI
                  setState(() {});
                },
                child: const Text("Back To Zero"),
              ),
              // Tombol untuk menambah nilai counter
              ElevatedButton(
                onPressed: () {
                  // Mencetak nilai counter ke debug log sebelum ditambah
                  log(counter.toString());
                  
                  // Memanggil setState() untuk memicu rebuild UI
                  setState(() {});
                  
                  // Menambah nilai counter
                  // Catatan pembelajaran: Best practice di Flutter adalah merubah nilai variabel
                  // sebelum setState() atau di dalam callback setState(() { counter++; }) agar alur kode lebih rapi.
                  counter++;
                },
                child: const Text("Tambah"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
