import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ppkd_b7/day_36/models/todo_model.dart';

/// Service untuk menangani operasi CRUD (Create, Read, Update, Delete)
/// data Todo pada koleksi `todos` di Cloud Firestore.
class FirestoreTodoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Referensi ke koleksi `todos` di Firestore.
  CollectionReference<Map<String, dynamic>> get _todosRef =>
      _firestore.collection('todos');

  /// Menambahkan item Todo baru ke Firestore untuk pengguna tertentu.
  Future<void> addTodo({
    required String title,
    required String description,
    required String userId,
  }) async {
    final todo = _createTodo(
      title: title,
      description: description,
      userId: userId,
    );

    await _todosRef.add(todo.toMap());
  }

  /// Mendapatkan aliran data realtime (Stream) daftar Todo milik user tertentu,
  /// diurutkan berdasarkan tanggal pembuatan secara menurun (terbaru di atas).
  Stream<List<TodoModel>> streamTodos(String userId) {
    return _todosRef
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => TodoModel.fromDocument(doc))
              .toList();
        });
  }

  /// Memperbarui judul dan deskripsi Todo berdasarkan ID dokumen Firestore.
  Future<void> updateTodo({
    required String id,
    required String title,
    required String description,
  }) async {
    await _todosRef.doc(id).update({
      'title': title,
      'description': description,
    });
  }

  /// Mengubah status penyelesaian (isCompleted) item Todo secara toggle (selesai/belum).
  Future<void> toggleTodoStatus(String id, bool currentStatus) async {
    await _todosRef.doc(id).update({'isCompleted': !currentStatus});
  }

  /// Menghapus dokumen Todo dari Firestore berdasarkan ID dokumen.
  Future<void> deleteTodo(String id) async {
    await _todosRef.doc(id).delete();
  }

  /// Helper internal untuk menginstansiasi objek [TodoModel] baru sebelum disimpan.
  TodoModel _createTodo({
    required String title,
    required String description,
    required String userId,
  }) {
    return TodoModel(
      id: '',
      title: title,
      description: description,
      isCompleted: false,
      userId: userId,
      createdAt: DateTime.now(),
    );
  }
}

