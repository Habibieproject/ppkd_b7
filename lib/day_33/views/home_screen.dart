import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ppkd_b7/day_20/constants/app_colors.dart';
import 'package:ppkd_b7/day_33/models/profile_response.dart';
import 'package:ppkd_b7/day_33/services/api_services.dart';
import 'package:ppkd_b7/day_33/services/dio_client.dart';
import 'package:ppkd_b7/day_33/services/token_storage.dart';
import 'package:ppkd_b7/day_33/views/edit_profile_screen.dart';
import 'package:ppkd_b7/day_33/views/login_screen.dart';

class HomeScreenDay33 extends StatefulWidget {
  const HomeScreenDay33({super.key});

  @override
  State<HomeScreenDay33> createState() => _HomeScreenDay33State();
}

class _HomeScreenDay33State extends State<HomeScreenDay33> {
  bool _isLoading = true;
  String? _errorMessage;
  ProfileResponse? _profileResponse;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final token = await TokenStorage.getToken();
      if (token == null || token.isEmpty) {
        setState(() {
          _isLoading = false;
          _errorMessage =
              "Token autentikasi tidak ditemukan. Silakan login kembali.";
        });
        return;
      }

      final dio = createDioClient();
      final apiService = ApiService(dio);

      final authHeader = token.startsWith('Bearer ') ? token : 'Bearer $token';
      final response = await apiService.getProfile(authHeader);

      if (!mounted) return;

      setState(() {
        _profileResponse = response;
        _isLoading = false;
      });
    } on DioException catch (e) {
      if (!mounted) return;

      String msg = "Gagal mengambil data profil.";
      if (e.response != null && e.response?.data != null) {
        final data = e.response?.data;
        if (data is Map<String, dynamic> && data.containsKey('message')) {
          msg = data['message'].toString();
        }
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        msg = "Koneksi internet bermasalah. Periksa jaringan Anda.";
      }

      setState(() {
        _errorMessage = msg;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage = "Terjadi kesalahan tidak terduga: $e";
        _isLoading = false;
      });
    }
  }

  Future<void> _navigateToEditProfile() async {
    final user = _profileResponse?.data;
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreenDay33(
          currentName: user?.name ?? "",
          currentEmail: user?.email ?? "",
        ),
      ),
    );

    if (result == true) {
      _fetchProfile();
    }
  }

  Future<void> _logout() async {
    await TokenStorage.clearToken();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreenDay33()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 800;
    final user = _profileResponse?.data;

    return Scaffold(
      backgroundColor: AppColors.bgSurface,
      appBar: AppBar(
        backgroundColor: AppColors.cardSurface,
        elevation: 0.5,
        surfaceTintColor: Colors.transparent,
        title: const Row(
          children: [
            Icon(Icons.school, color: AppColors.primaryNavy, size: 28),
            SizedBox(width: 8),
            Text(
              "PrepMaster - User Profile",
              style: TextStyle(
                color: AppColors.primaryNavy,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.primaryNavy),
            tooltip: "Refresh Data",
            onPressed: _fetchProfile,
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            tooltip: "Logout",
            onPressed: _logout,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _fetchProfile,
        color: AppColors.primaryNavy,
        child: Center(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 32 : 16,
              vertical: 24,
            ),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 700),
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
              padding: const EdgeInsets.all(24),
              child: _buildBodyContent(user),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBodyContent(user) {
    if (_isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 48),
        child: Column(
          children: [
            CircularProgressIndicator(color: AppColors.primaryNavy),
            SizedBox(height: 16),
            Text(
              "Mengambil data profil dari server...",
              style: TextStyle(color: AppColors.textSub, fontSize: 14),
            ),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          children: [
            const Icon(Icons.error_outline, color: Colors.redAccent, size: 54),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.redAccent,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryNavy,
                  ),
                  onPressed: _fetchProfile,
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  label: const Text(
                    "Coba Lagi",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: _logout,
                  icon: const Icon(Icons.login, color: Colors.redAccent),
                  label: const Text(
                    "Ke Halaman Login",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Banner / Header Avatar
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primaryNavy,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: Colors.amberAccent,
                child: Text(
                  (user?.name != null && user!.name!.isNotEmpty)
                      ? user.name![0].toUpperCase()
                      : "U",
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryNavy,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.name ?? "Nama Tidak Tersedia",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user?.email ?? "Email Tidak Tersedia",
                      style: const TextStyle(
                        color: Color(0xFFDCE1FF),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.amberAccent),
                tooltip: "Edit Profil",
                onPressed: _navigateToEditProfile,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // API Message Banner
        if (_profileResponse?.message != null) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.successBg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.successGreen.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: AppColors.successGreen),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _profileResponse!.message!,
                    style: const TextStyle(
                      color: AppColors.textMain,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],

        const Text(
          "Detail Informasi Profil",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textMain,
          ),
        ),
        const SizedBox(height: 12),

        // List Profile Fields
        _buildProfileTile(
          icon: Icons.tag,
          label: "User ID",
          value: user?.id?.toString() ?? "-",
        ),
        _buildProfileTile(
          icon: Icons.person_outline,
          label: "Nama Lengkap",
          value: user?.name ?? "-",
        ),
        _buildProfileTile(
          icon: Icons.email_outlined,
          label: "Alamat Email",
          value: user?.email ?? "-",
        ),
        _buildProfileTile(
          icon: Icons.mark_email_read_outlined,
          label: "Email Verified At",
          value: user?.emailVerifiedAt ?? "Belum Diverifikasi",
        ),
        _buildProfileTile(
          icon: Icons.calendar_today_outlined,
          label: "Dibuat Pada (Created At)",
          value: user?.createdAt ?? "-",
        ),
        _buildProfileTile(
          icon: Icons.update_outlined,
          label: "Diperbarui Pada (Updated At)",
          value: user?.updatedAt ?? "-",
        ),

        const SizedBox(height: 28),
        const Divider(color: AppColors.borderSubtle),
        const SizedBox(height: 16),

        // Footer Action Buttons
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryNavy,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _navigateToEditProfile,
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text(
                  "Edit Profil",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: AppColors.primaryNavy),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _fetchProfile,
                icon: const Icon(Icons.refresh, color: AppColors.primaryNavy),
                label: const Text(
                  "Refresh",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryNavy,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: Colors.redAccent),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _logout,
                icon: const Icon(Icons.logout, color: Colors.redAccent),
                label: const Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.inputBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryNavy, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSub,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.textMain,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
