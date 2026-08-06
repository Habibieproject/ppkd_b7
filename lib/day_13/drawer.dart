import 'package:flutter/material.dart';
import 'package:ppkd_b7/day_10/image.dart';
import 'package:ppkd_b7/day_13/input_widget/input_widget.dart';
import 'package:ppkd_b7/day_15/list.dart';
import 'package:ppkd_b7/day_15/list_model.dart';
import 'package:ppkd_b7/day_15/list_of_map.dart';
import 'package:ppkd_b7/day_16/text_form_field.dart';
import 'package:ppkd_b7/day_6/expanded.dart';
import 'package:ppkd_b7/day_8/stack.dart';
import 'package:ppkd_b7/extension/navigator.dart';

// Widget utama DrawerDay13 berupa StatefulWidget agar dapat memperbarui tampilannya saat item menu dipilih.
class DrawerDay13 extends StatefulWidget {
  const DrawerDay13({super.key});

  @override
  State<DrawerDay13> createState() => _DrawerDay13State();
}

class _DrawerDay13State extends State<DrawerDay13> {
  // Menyimpan indeks widget/halaman yang saat ini dipilih dan aktif.
  int _selectedBottom = 0;

  // Fungsi untuk mengubah halaman aktif berdasarkan indeks yang dipilih dari menu Drawer.
  void changeBottom(int index) {
    _selectedBottom = index;
    print("Ini adalah value dari $_selectedBottom");
    // setState digunakan untuk memberi tahu Flutter bahwa ada perubahan state sehingga UI perlu di-rebuild.
    setState(() {});
    // Menutup menu Drawer setelah item diklik (menggunakan extension pop pada context).
    context.pop();
  }

  // Daftar halaman/widget yang akan dirender di bagian body Scaffold secara dinamis.
  final List<Widget> _widgetOptions = [
    ExpandedDay6(), // Halaman latihan Expanded Day 6
    StackDay8(), // Halaman latihan Stack Day 8
    ShowImageDay10(), // Halaman latihan Image Day 10
    InputWidgetDay13(), // Halaman latihan Input Widget Day 13
    ListDataDay15(), // Halaman latihan List buah sederhana Day 15
    ListOfMapDay15(), // Halaman latihan List data dari Map Day 15
    ListOfModelDay15(), // Halaman latihan List data dari Model Day 15
    TextFormFieldDay16(), // Halaman latihan Form Validasi Day 16
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar di bagian atas halaman dengan judul "Drawer"
      appBar: AppBar(title: Text("Drawer")),
      // Menambahkan menu Drawer di sebelah kiri layar
      drawer: Drawer(
        child: ListView(
          children: [
            // Pilihan Menu 1: Home
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                changeBottom(0); // Berpindah ke index 0 (ExpandedDay6)
              },
            ),
            // Pilihan Menu 2: School
            ListTile(
              leading: Icon(Icons.school),
              title: Text("school"),
              onTap: () {
                changeBottom(1); // Berpindah ke index 1 (StackDay8)
              },
            ),
            // Pilihan Menu 3: Business
            ListTile(
              leading: Icon(Icons.business),
              title: Text("business"),
              onTap: () {
                changeBottom(2); // Berpindah ke index 2 (ShowImageDay10)
              },
            ),
            // Pilihan Menu 4: Input Widget
            ListTile(
              leading: Icon(Icons.input),
              title: Text("Input Widget"),
              onTap: () {
                changeBottom(3); // Berpindah ke index 3 (InputWidgetDay13)
              },
            ),
            // Pilihan Menu 5: List Data
            ListTile(
              leading: Icon(Icons.list),
              title: Text("List Data"),
              onTap: () {
                changeBottom(4); // Berpindah ke index 4 (ListDataDay15)
              },
            ),
            // Pilihan Menu 6: List of Map
            ListTile(
              leading: Icon(Icons.map),
              title: Text("List of Map"),
              onTap: () {
                changeBottom(5); // Berpindah ke index 5 (ListOfMapDay15)
              },
            ),
            // Pilihan Menu 7: List of Model
            ListTile(
              leading: Icon(Icons.layers),
              title: Text("List of Model"),
              onTap: () {
                changeBottom(6); // Berpindah ke index 6 (ListOfModelDay15)
              },
            ),
            // Pilihan Menu 8: Text Form Field
            ListTile(
              leading: Icon(Icons.text_fields),
              title: Text("Text Form Field"),
              onTap: () {
                changeBottom(7); // Berpindah ke index 7 (TextFormFieldDay16)
              },
            ),
          ],
        ),
      ),
      // Menampilkan widget yang sesuai dengan indeks _selectedBottom yang aktif
      body: _widgetOptions.elementAt(_selectedBottom),
    );
  }
}

