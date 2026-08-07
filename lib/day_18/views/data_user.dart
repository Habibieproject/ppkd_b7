import 'package:flutter/material.dart';
import 'package:ppkd_b7/day_18/database/db_helper.dart';
import 'package:ppkd_b7/day_18/models/user_login_model.dart';

class DataUserDay18 extends StatefulWidget {
  const DataUserDay18({super.key});

  @override
  State<DataUserDay18> createState() => _DataUserDay18State();
}

class _DataUserDay18State extends State<DataUserDay18> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<UserModelSQL>>(
              future: DBHelper().getAllUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Terjadi kesalahan: ${snapshot.error}'),
                  ); // Center
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('Tidak ada data pengguna.'),
                  ); // Center
                }

                final daftarPengguna = snapshot.data!;

                return ListView.builder(
                  itemCount: daftarPengguna.length,
                  itemBuilder: (context, index) {
                    final user = daftarPengguna[index];
                    return Card(
                      child: ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.person),
                        ), // CircleAvatar
                        title: Text(user.email),
                        subtitle: Text('Password: ${user.password}'),
                      ), // ListTile
                    ); // Card
                  },
                ); // ListView.builder
              },
            ), // FutureBuilder
          ),
        ],
      ),
    );
  }
}
