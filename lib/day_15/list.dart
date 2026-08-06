import 'package:flutter/material.dart';

// Widget ListDataDay15 adalah StatelessWidget yang menampilkan daftar nama buah
// menggunakan widget ListView.builder.
class ListDataDay15 extends StatelessWidget {
  ListDataDay15({super.key});

  // Dummy data berupa List of Strings yang berisi daftar nama-nama buah.
  final List<String> namaBuah = [
    "Apel",
    "Mangga",
    "Pisang",
    "Jeruk",
    "Anggur",
    "Semangka",
    "Melon",
    "Stroberi",
    "Nanas",
    "Pepaya",
    "Durian",
    "Rambutan",
    "Nangka",
    "Salak",
    "Alpukat",
    "Ceri",
    "Kelapa",
    "Manggis",
    "Jambu",
    "Kiwi",
    "Markisa",
    "Lemon",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ListView.builder digunakan untuk membuat list secara dinamis dan efisien,
      // hanya merender item yang terlihat di layar.
      body: ListView.builder(
        // Menentukan jumlah total item di dalam list.
        itemCount: namaBuah.length,
        // Fungsi builder untuk membuat widget bagi setiap item di dalam list berdasarkan indexnya.
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              namaBuah[index],
              style: const TextStyle(fontSize: 18),
            ),
          );
        },
      ),
    );
  }
}

