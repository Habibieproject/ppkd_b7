import 'package:flutter/material.dart';
import 'package:ppkd_b7/constant/app_color.dart';
import 'package:ppkd_b7/day_36/models/todo_model.dart';
import 'package:ppkd_b7/day_36/models/user_model.dart';
import 'package:ppkd_b7/day_36/services/firebase_auth_service.dart';
import 'package:ppkd_b7/day_36/services/firestore_todo_service.dart';
import 'package:ppkd_b7/day_36/views/login_screen.dart';
import 'package:ppkd_b7/extension/navigator.dart';

/// Halaman Dashboard Utama Day 36
/// Menampilkan profil pengguna yang terautentikasi dan daftar Todo secara realtime (StreamBuilder).
class TodoDashboardDay36 extends StatefulWidget {
  const TodoDashboardDay36({super.key});

  @override
  State<TodoDashboardDay36> createState() => _TodoDashboardDay36State();
}

class _TodoDashboardDay36State extends State<TodoDashboardDay36> {
  // Service otentikasi Firebase dan Firestore Todo.
  final _authService = FirebaseAuthService();
  final _todoService = FirestoreTodoService();

  late final String _currentUid;
  Future<UserModelFirebase?>? _userFuture;

  @override
  void initState() {
    super.initState();
    // Mendapatkan UID dari pengguna yang sedang aktif.
    _currentUid = _authService.currentUserId ?? '';
    if (_currentUid.isEmpty) {
      // Jika tidak ada user terautentikasi, kembalikan ke layar Login.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        context.pushAndRemoveAll(const LoginScreenDay36());
      });
      return;
    }

    // Mengambil data detail profil pengguna dari Firestore.
    _userFuture = _authService.getUserDetails(_currentUid);
  }

  /// Menampilkan dialog konfirmasi keluar (logout) dari aplikasi.
  void _logout() async {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Apakah Anda yakin ingin keluar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColor.redColor),
            onPressed: () async {
              Navigator.pop(dialogContext); // Menutup dialog
              await _authService.signOut();
              if (!mounted) return;
              context.pushAndRemoveAll(const LoginScreenDay36());
            },
            child: const Text('Keluar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  /// Menampilkan modal bottom sheet untuk form Tambah/Edit Task.
  /// Jika [todo] diisi, maka form berfungsi untuk mengedit task yang ada.
  void _showTodoForm({TodoModel? todo}) {
    final titleController = TextEditingController(text: todo?.title ?? '');
    final descController = TextEditingController(text: todo?.description ?? '');
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                todo == null ? 'Tambah Task Baru' : 'Edit Task',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Judul Task',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Judul tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: descController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () async {
                  if (!formKey.currentState!.validate()) return;

                  try {
                    if (todo == null) {
                      // Tambah data baru ke Firestore
                      await _todoService.addTodo(
                        title: titleController.text.trim(),
                        description: descController.text.trim(),
                        userId: _currentUid,
                      );
                    } else {
                      // Perbarui data yang sudah ada di Firestore
                      await _todoService.updateTodo(
                        id: todo.id,
                        title: titleController.text.trim(),
                        description: descController.text.trim(),
                      );
                    }
                  } catch (e) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Gagal menyimpan task: $e')),
                    );
                    return;
                  }

                  if (!mounted || !sheetContext.mounted) return;
                  Navigator.pop(sheetContext);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        todo == null
                            ? 'Task berhasil ditambahkan'
                            : 'Task berhasil diupdate',
                      ),
                    ),
                  );
                },
                child: Text(
                  todo == null ? 'Tambah' : 'Simpan',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ).whenComplete(() {
      titleController.dispose();
      descController.dispose();
    });
  }

  /// Menampilkan dialog konfirmasi hapus Task dari Firestore.
  void _deleteTodo(String todoId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus Task'),
        content: const Text('Apakah Anda yakin ingin menghapus task ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColor.redColor),
            onPressed: () async {
              Navigator.pop(dialogContext); // Menutup dialog
              try {
                await _todoService.deleteTodo(todoId);
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Gagal menghapus task: $e')),
                );
                return;
              }

              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Task berhasil dihapus')),
              );
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    if (_currentUid.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // User Info Section
          FutureBuilder<UserModelFirebase?>(
            future: _userFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  color: AppColor.primaryColor.withValues(alpha: 0.1),
                  child: const Center(child: CircularProgressIndicator()),
                );
              }

              final user = snapshot.data;
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor.withValues(alpha: 0.08),
                  border: const Border(
                    bottom: BorderSide(color: AppColor.borderColor),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: AppColor.primaryColor,
                      child: Text(
                        (user?.name.isNotEmpty ?? false)
                            ? user!.name[0].toUpperCase()
                            : 'U',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.name ?? 'Nama User',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.blackText,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            user?.email ?? 'email@firebase.com',
                            style: const TextStyle(
                              color: AppColor.greyText,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // Realtime Todos List Section
          Expanded(
            child: StreamBuilder<List<TodoModel>>(
              stream: _todoService.streamTodos(_currentUid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        'Terjadi kesalahan saat memuat data: ${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColor.redColor),
                      ),
                    ),
                  );
                }

                final todos = snapshot.data ?? [];
                if (todos.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.playlist_add_check_outlined,
                          size: 64,
                          color: AppColor.gray88,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Belum ada task. Tambah sekarang!',
                          style: TextStyle(color: AppColor.greyText),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: todos.length,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: AppColor.borderColor),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        leading: Checkbox(
                          activeColor: AppColor.primaryColor,
                          value: todo.isCompleted,
                          onChanged: (_) async {
                            try {
                              await _todoService.toggleTodoStatus(
                                todo.id,
                                todo.isCompleted,
                              );
                            } catch (e) {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Gagal mengubah status task: $e',
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        title: Text(
                          todo.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                            color: todo.isCompleted
                                ? AppColor.greyText
                                : AppColor.blackText,
                          ),
                        ),
                        subtitle: todo.description.isNotEmpty
                            ? Text(
                                todo.description,
                                style: TextStyle(
                                  decoration: todo.isCompleted
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color: AppColor.greyText,
                                ),
                              )
                            : null,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.edit_outlined,
                                color: AppColor.blueButtons,
                              ),
                              onPressed: () => _showTodoForm(todo: todo),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: AppColor.redColor,
                              ),
                              onPressed: () => _deleteTodo(todo.id),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primaryColor,
        onPressed: () => _showTodoForm(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
