import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ppkd_b7/day_20/constants/app_colors.dart';
import 'package:ppkd_b7/day_33/services/api_services.dart';
import 'package:ppkd_b7/day_33/services/dio_client.dart';
import 'package:ppkd_b7/day_33/services/token_storage.dart';

class EditProfileScreenDay33 extends StatefulWidget {
  final String currentName;
  final String currentEmail;

  const EditProfileScreenDay33({
    super.key,
    required this.currentName,
    required this.currentEmail,
  });

  @override
  State<EditProfileScreenDay33> createState() => _EditProfileScreenDay33State();
}

class _EditProfileScreenDay33State extends State<EditProfileScreenDay33> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _emailController = TextEditingController(text: widget.currentEmail);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submitUpdate() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final token = await TokenStorage.getToken();
      if (token == null || token.isEmpty) {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Token tidak ditemukan. Silakan login kembali."),
            backgroundColor: Colors.redAccent,
          ),
        );
        return;
      }

      final dio = createDioClient();
      final apiService = ApiService(dio);

      final authHeader = token.startsWith('Bearer ') ? token : 'Bearer $token';
      final response = await apiService.updateProfile(authHeader, {
        "name": _nameController.text.trim(),
      });

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message ?? "Profil berhasil diperbarui"),
          backgroundColor: AppColors.successGreen,
        ),
      );

      // Kembalikan nilai true ke HomeScreen agar dapat merefresh data
      Navigator.pop(context, true);
    } on DioException catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      String errorMessage = "Gagal memperbarui profil. Silakan coba lagi.";
      if (e.response != null && e.response?.data != null) {
        final data = e.response?.data;
        if (data is Map<String, dynamic> && data.containsKey('message')) {
          errorMessage = data['message'].toString();
        }
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        errorMessage = "Koneksi internet bermasalah. Periksa jaringan Anda.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.redAccent,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Terjadi kesalahan tidak terduga: $e"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 800;

    return Scaffold(
      backgroundColor: AppColors.bgSurface,
      appBar: AppBar(
        backgroundColor: AppColors.cardSurface,
        elevation: 0.5,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          "Edit Profil Pengguna",
          style: TextStyle(
            color: AppColors.primaryNavy,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryNavy),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 32 : 16,
            vertical: 24,
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            decoration: BoxDecoration(
              color: AppColors.cardSurface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderSubtle, width: 1),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(28),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Ubah Informasi Profil",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMain,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Perbarui nama profil Anda di bawah ini.",
                    style: TextStyle(fontSize: 14, color: AppColors.textSub),
                  ),
                  const SizedBox(height: 28),

                  // Field: Nama
                  const Text(
                    "Nama Lengkap",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSub,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Nama lengkap tidak boleh kosong";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Masukkan nama lengkap baru",
                      prefixIcon: const Icon(Icons.person_outline,
                          color: AppColors.textSub),
                      filled: true,
                      fillColor: AppColors.inputBg,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: AppColors.borderSubtle),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: AppColors.borderSubtle),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppColors.primaryNavy,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Field: Email (Read Only)
                  const Text(
                    "Alamat Email (Tidak dapat diubah)",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSub,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _emailController,
                    enabled: false,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email_outlined,
                          color: AppColors.textSub),
                      filled: true,
                      fillColor: AppColors.borderSubtle.withValues(alpha: 0.3),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: AppColors.borderSubtle),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: const BorderSide(color: AppColors.borderSubtle),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: _isLoading
                              ? null
                              : () => Navigator.pop(context),
                          child: const Text(
                            "Batal",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSub,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryNavy,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 1,
                          ),
                          onPressed: _isLoading ? null : _submitUpdate,
                          child: _isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Text(
                                  "Simpan Perubahan",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
