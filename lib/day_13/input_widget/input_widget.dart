import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Widget utama InputWidgetDay13 yang menampilkan berbagai macam komponen input (Checkbox, Switch, Dropdown, Date & Time Picker).
class InputWidgetDay13 extends StatefulWidget {
  const InputWidgetDay13({super.key});

  @override
  State<InputWidgetDay13> createState() => _InputWidgetDay13State();
}

class _InputWidgetDay13State extends State<InputWidgetDay13> {
  // State untuk menyimpan nilai Checkbox (true = dicentang, false = tidak dicentang).
  bool _isCheck = false;

  // State untuk menyimpan status Switch (true = aktif/menyala, false = mati).
  // Digunakan juga untuk mengubah warna latar belakang container (Putih/Hitam).
  bool _isOn = false;

  // State untuk menyimpan nilai yang dipilih dari Dropdown (Merah, Kuning, atau Hijau).
  String? _selected;

  // State untuk menyimpan tanggal yang dipilih dari Date Picker.
  DateTime? _selectedTime;

  // State untuk menyimpan waktu (jam & menit) yang dipilih dari Time Picker.
  TimeOfDay? _selectedTimeOfDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // Mengatur warna latar belakang secara dinamis berdasarkan state _isOn (Switch).
      color: _isOn ? Colors.white : Colors.black,
      child: Column(
        children: [
          // Menampilkan widget Checkbox
          checkboxWidget(),
          // Menampilkan widget Switch
          switchWidget(),
          // Menampilkan widget Dropdown
          dropdownWidget(),
          // Menampilkan widget Date Picker (Pemilih Tanggal)
          datePickerWidget(context),
          // Pemilih Waktu (Time Picker) langsung didefinisikan di sini
          ElevatedButton(
            onPressed: () async {
              // Memunculkan dialog Time Picker bawaan Flutter.
              final TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              // Jika user memilih waktu (tidak batal), simpan nilainya ke state dan rebuild UI.
              if (picked != null) {
                setState(() {
                  _selectedTimeOfDay = picked;
                });
              }
            },
            child: Text("Pilih Jam"),
          ),
          // Menampilkan representasi String mentah dari TimeOfDay yang dipilih.
          Text(
            _selectedTimeOfDay == null
                ? "Anda belum pilih jam"
                : _selectedTimeOfDay.toString(),
          ),
          // Menampilkan waktu terpilih dengan format 24 Jam (HH:mm) menggunakan DateFormat.
          Text(
            _selectedTimeOfDay == null
                ? "Anda belum pilih jam"
                : DateFormat('HH:mm').format(
                    DateTime(
                      0, 0, 0,
                      _selectedTimeOfDay!.hour,
                      _selectedTimeOfDay!.minute,
                    ),
                  ),
          ),
          // Menampilkan waktu terpilih dengan format 12 Jam beserta AM/PM (HH:mm a).
          Text(
            _selectedTimeOfDay == null
                ? "Anda belum pilih jam"
                : DateFormat('HH:mm a').format(
                    DateTime(
                      0, 0, 0,
                      _selectedTimeOfDay!.hour,
                      _selectedTimeOfDay!.minute,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // Widget kustom untuk Date Picker (Pemilih Tanggal).
  Column datePickerWidget(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            // Memunculkan dialog Date Picker bawaan Flutter.
            final DateTime? picked = await showDatePicker(
              context: context,
              firstDate: DateTime(2021),
              lastDate: DateTime.now(),
              initialDate: DateTime.now(),
            );
            // Jika user memilih tanggal, simpan nilainya ke state dan rebuild UI.
            if (picked != null) {
              setState(() {
                _selectedTime = picked;
              });
            }
          },
          child: Text("Pilih Tanggal"),
        ),
        // Menampilkan tanggal mentah (toString).
        Text(
          _selectedTime == null
              ? "Anda belum pilih tanggal"
              : _selectedTime.toString(),
        ),
        // Menampilkan tahun saja (yyyy).
        Text(
          _selectedTime == null
              ? "Anda belum pilih tanggal"
              : DateFormat('yyyy').format(_selectedTime ?? DateTime.now()),
        ),
        // Menampilkan format lengkap Indonesia: Hari, Tanggal Bulan Tahun (misal: Senin, 03 Agustus 2026).
        Text(
          _selectedTime == null
              ? "Anda belum pilih tanggal"
              : DateFormat(
                  'EEEE, dd MMMM yyyy',
                  'id_ID',
                ).format(_selectedTime ?? DateTime.now()),
        ),
        // Menampilkan format hari singkat: Sen, 03 Agustus 2026.
        Text(
          _selectedTime == null
              ? "Anda belum pilih tanggal"
              : DateFormat(
                  'EEE, dd MMMM yyyy',
                  'id_ID',
                ).format(_selectedTime ?? DateTime.now()),
        ),
        // Menampilkan format hari singkat dan bulan singkat: Sen, 03/Ags/2026.
        Text(
          _selectedTime == null
              ? "Anda belum pilih tanggal"
              : DateFormat(
                  'EEE, dd/MMM/yyyy',
                  'id_ID',
                ).format(_selectedTime ?? DateTime.now()),
        ),
      ],
    );
  }

  // Widget kustom untuk Dropdown (Pemilih Warna).
  Column dropdownWidget() {
    return Column(
      children: [
        // Dropdown Button standar.
        DropdownButton(
          dropdownColor: Colors.blue,
          value: _selected,
          // Membuat item pilihan secara dinamis dari list warna.
          items: ["Merah", "Kuning", "Hijau"].map((String val) {
            return DropdownMenuItem(value: val, child: Text(val));
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selected = value;
            });
          },
        ),
        // Dropdown Button Form Field yang terintegrasi dengan dekorasi form (InputDecoration).
        DropdownButtonFormField(
          decoration: InputDecoration(
            // Warna latar belakang kolom dropdown berubah dinamis menyesuaikan warna pilihan.
            fillColor: _selected == "Merah"
                ? Colors.red
                : _selected == "Kuning"
                ? Colors.yellow
                : _selected == "Hijau"
                ? Colors.green
                : Colors.white,
            filled: true,
          ),
          dropdownColor: Colors.blue,
          initialValue: _selected,
          items: ["Merah", "Kuning", "Hijau"].map((String val) {
            return DropdownMenuItem(value: val, child: Text(val));
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selected = value;
            });
          },
        ),
        // Menampilkan teks warna terpilih.
        Text(_selected.toString()),
        // Kotak preview warna untuk menunjukkan visualisasi warna yang sedang aktif dipilih.
        Container(
          height: 50,
          width: 50,
          color: _selected == "Merah"
              ? Colors.red
              : _selected == "Kuning"
              ? Colors.yellow
              : _selected == "Hijau"
              ? Colors.green
              : Colors.white,
        ),
      ],
    );
  }

  // Widget kustom untuk Switch (Sakelar lampu/mode tema).
  Column switchWidget() {
    return Column(
      children: [
        Switch(
          activeThumbColor: Colors.amber,
          inactiveThumbColor: Colors.black,
          value: _isOn,
          onChanged: (value) {
            _isOn = value ?? false;
            setState(() {});
          },
        ),
        // Mengubah warna teks secara kontras dengan latar belakang agar tetap terbaca.
        Text(
          _isOn ? "Matiin" : "Hidupin",
          style: TextStyle(color: _isOn ? Colors.black : Colors.white),
        ),
      ],
    );
  }

  // Widget kustom untuk Checkbox.
  Column checkboxWidget() {
    return Column(
      children: [
        Checkbox(
          value: _isCheck,
          onChanged: (value) {
            _isCheck = value ?? false;
            setState(() {});
          },
        ),
        // Teks penjelas status checkbox.
        Text(_isCheck ? "Sudah di ceklist" : "Belum di ceklist"),
      ],
    );
  }
}
