import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ppkd_b7/day_36/models/user_model.dart';

/// Service khusus untuk mengelola otentikasi Firebase (Email/Password & Google Sign In)
/// serta sinkronisasi data profil pengguna ke Cloud Firestore.
class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Referensi ke koleksi `users` di Cloud Firestore.
  CollectionReference<Map<String, dynamic>> get _usersRef =>
      _firestore.collection('users');

  /// Stream untuk memantau perubahan status login pengguna (LoggedIn/LoggedOut).
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Mendapatkan User ID (UID) dari pengguna yang sedang login saat ini.
  String? get currentUserId => _auth.currentUser?.uid;

  /// Mendaftarkan pengguna baru dengan email & password, kemudian menyimpan profilnya ke Firestore.
  Future<UserCredential> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final user = userCredential.user;
    if (user != null) {
      await _saveUserData(user: user, name: name, email: email.trim());
    }

    return userCredential;
  }

  /// Melakukan login dengan email dan password.
  Future<UserCredential> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  /// Melakukan login menggunakan akun Google. Jika pengguna baru, data profil akan disimpan ke Firestore.
  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null; // Pengguna membatalkan proses sign in

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    final user = userCredential.user;

    if (user != null) {
      final doc = await _usersRef.doc(user.uid).get();
      if (!doc.exists) {
        await _saveUserData(
          user: user,
          name: user.displayName ?? 'Google User',
          email: user.email ?? '',
        );
      }
    }

    return userCredential;
  }

  /// Mengambil data rincian profil pengguna dari dokumen Firestore berdasarkan UID.
  Future<UserModelFirebase?> getUserDetails(String uid) async {
    final doc = await _usersRef.doc(uid).get();
    if (doc.exists && doc.data() != null) {
      return UserModelFirebase.fromMap(doc.data()!);
    }
    return null;
  }

  /// Melakukan proses keluar (sign out) dari akun Google dan Firebase Auth.
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (_) {}
    await _auth.signOut();
  }

  /// Helper internal untuk menyimpan data profil pengguna baru ke Firestore.
  Future<void> _saveUserData({
    required User user,
    required String name,
    required String email,
  }) async {
    final userModelFirebase = UserModelFirebase(
      uid: user.uid,
      name: name,
      email: email,
      createdAt: DateTime.now(),
    );

    await _usersRef.doc(user.uid).set(userModelFirebase.toMap());
  }
}

