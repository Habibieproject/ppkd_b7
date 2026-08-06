import 'package:flutter/material.dart';
import 'package:ppkd_b7/day_15/model/buah_model.dart';

// Widget ListOfModelDay15 menampilkan data dinamis dari struktur data List of Models.
// Menggunakan class model (BuahModel) memberikan keuntungan type-safety (keamanan tipe data) 
// dibanding menggunakan Map, sehingga meminimalisir kesalahan pengetikan key (typo).
class ListOfModelDay15 extends StatelessWidget {
  ListOfModelDay15({super.key});

  // Dummy data menggunakan tipe List<BuahModel> yang berisi instansi objek BuahModel.
  final List<BuahModel> dataProduk = [
    BuahModel(nama: "Apel", harga: "25000", asal: "Jepang"),
    BuahModel(nama: "Pisang", harga: "15000", asal: "Indonesia"),
    BuahModel(nama: "Jeruk", harga: "20000", asal: "Spanyol"),
    BuahModel(nama: "Mangga", harga: "30000", asal: "India"),
    BuahModel(nama: "Anggur", harga: "40000", asal: "Italia"),
    BuahModel(nama: "Semangka", harga: "18000", asal: "Brazil"),
    BuahModel(nama: "Melon", harga: "22000", asal: "Australia"),
    BuahModel(nama: "Kiwi", harga: "50000", asal: "Selandia Baru"),
    BuahModel(nama: "Nanas", harga: "12000", asal: "Filipina"),
    BuahModel(nama: "Stroberi", harga: "45000", asal: "Amerika Serikat"),
    BuahModel(nama: "Durian", harga: "60000", asal: "Thailand"),
    BuahModel(nama: "Rambutan", harga: "25000", asal: "Malaysia"),
    BuahModel(nama: "Pepaya", harga: "10000", asal: "Meksiko"),
    BuahModel(nama: "Jambu", harga: "15000", asal: "Vietnam"),
    BuahModel(nama: "Leci", harga: "35000", asal: "Cina"),
    BuahModel(nama: "Delima", harga: "30000", asal: "Iran"),
    BuahModel(nama: "Sirsak", harga: "20000", asal: "Karibia"),
    BuahModel(nama: "Ceri", harga: "55000", asal: "Turki"),
    BuahModel(nama: "Alpukat", harga: "40000", asal: "Meksiko"),
    BuahModel(nama: "Blueberry", harga: "60000", asal: "Kanada"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menggunakan ListView.separated untuk menyusun item secara teratur dengan pemisah di antaranya.
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8);
        },
        itemCount: dataProduk.length,
        itemBuilder: (BuildContext context, int index) {
          // Mengakses data per objek dari index list.
          final produk = dataProduk[index];
          return ListTile(
            tileColor: index % 2 == 0 ? Colors.red[200] : Colors.grey[200],
            // Mengakses properti objek secara langsung (type-safe).
            title: Text(produk.nama),
            subtitle: Text(produk.asal),
            trailing: Text(produk.harga),
          );
        },
      ),
    );
  }
}

