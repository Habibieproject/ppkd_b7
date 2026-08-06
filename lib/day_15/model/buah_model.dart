import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

// Class BuahModel merepresentasikan model data buah.
// Model ini mempermudah pengelolaan data dan konversi format data (Serialization/Deserialization).
class BuahModel {
  final String nama;
  final String harga;
  final String asal;

  // Constructor wajib diisi untuk mendefinisikan instansi baru dari BuahModel.
  BuahModel({required this.nama, required this.harga, required this.asal});

  // Mengubah objek BuahModel menjadi tipe Map<String, dynamic> (untuk kebutuhan API/Local Database).
  Map<String, dynamic> toMap() {
    return <String, dynamic>{'nama': nama, 'harga': harga, 'asal': asal};
  }

  // Factory constructor untuk membuat objek BuahModel baru dari struktur Map<String, dynamic>.
  factory BuahModel.fromMap(Map<String, dynamic> map) {
    return BuahModel(
      nama: map['nama'] as String,
      harga: map['harga'] as String,
      asal: map['asal'] as String,
    );
  }

  // Mengubah objek BuahModel menjadi representasi string JSON.
  String toJson() => json.encode(toMap());

  // Factory constructor untuk membuat objek BuahModel dari representasi string JSON.
  factory BuahModel.fromJson(String source) =>
      BuahModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

