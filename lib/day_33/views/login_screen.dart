import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ppkd_b7/day_20/constants/app_colors.dart';
import 'package:ppkd_b7/day_33/services/api_services.dart';
import 'package:ppkd_b7/day_33/services/dio_client.dart';
import 'package:ppkd_b7/day_33/services/token_storage.dart';
import 'package:ppkd_b7/day_33/views/home_screen.dart';
import 'package:ppkd_b7/day_33/views/register_screen.dart';

class LoginScreenDay33 extends StatefulWidget {
  const LoginScreenDay33({super.key});

  @override
  State<LoginScreenDay33> createState() => _LoginScreenDay33State();
}

class _LoginScreenDay33State extends State<LoginScreenDay33> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isObscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final dio = createDioClient();
      final apiService = ApiService(dio);

      final response = await apiService.login({
        "email": _emailController.text.trim(),
        "password": _passwordController.text,
      });

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      final token = response.data?.token;
      if (token != null && token.isNotEmpty) {
        await TokenStorage.saveToken(token);
      }

      _showSuccessDialog(
        response.message ?? "Login berhasil",
        userName: response.data?.user?.name ?? "",
      );
    } on DioException catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      String errorMessage = "Terjadi kesalahan. Silakan coba lagi.";
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

  void _showSuccessDialog(String message, {String userName = ""}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(
                    color: AppColors.successBg,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_outline,
                    color: AppColors.successGreen,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMain,
                  ),
                ),
                if (userName.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    "Selamat datang kembali, $userName!",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryNavy,
                    ),
                  ),
                ],
                const SizedBox(height: 10),
                const Text(
                  "Anda berhasil masuk ke akun PrepMaster Anda.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSub,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryNavy,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreenDay33(),
                        ),
                      );
                    },
                    child: const Text(
                      "Lanjutkan ke Dashboard",
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
          ),
        );
      },
    );
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
        title: const Row(
          children: [
            Icon(Icons.school, color: AppColors.primaryNavy, size: 28),
            SizedBox(width: 8),
            Text(
              "PrepMaster",
              style: TextStyle(
                color: AppColors.primaryNavy,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 32 : 16,
            vertical: 24,
          ),
          child: Container(
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
            clipBehavior: Clip.antiAlias,
            child: isDesktop
                ? IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Banner Kiri (Desktop)
                        Expanded(
                          child: Container(
                            color: AppColors.primaryNavy,
                            padding: const EdgeInsets.all(40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Welcome Back to PrepMaster",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        height: 1.3,
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      "Continue your learning journey and achieve your target TOEFL score.",
                                      style: TextStyle(
                                        color: Color(0xFFDCE1FF),
                                        fontSize: 14,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 32),
                                Column(
                                  children: [
                                    _buildFeatureItem(
                                      icon: Icons.lock_clock,
                                      title: "Secure Access",
                                      subtitle:
                                          "Protected authentication with encrypted tokens.",
                                    ),
                                    const SizedBox(height: 16),
                                    _buildFeatureItem(
                                      icon: Icons.speed,
                                      title: "Real-time Progress",
                                      subtitle:
                                          "Pick up right where you left off.",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Form Kanan
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(40),
                            child: _buildForm(context),
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(24),
                    child: _buildForm(context),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.navyContainer.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.amberAccent, size: 28),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(color: Color(0xFFB6C4FF), fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Sign In to Your Account",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textMain,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "Enter your email and password to access your dashboard.",
            style: TextStyle(fontSize: 14, color: AppColors.textSub),
          ),
          const SizedBox(height: 28),

          // Field: Email
          const Text(
            "Email Address",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textSub,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Email harus diisi";
              }
              if (!value.contains("@")) {
                return "Format email tidak valid";
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "name@example.com",
              hintStyle: TextStyle(
                color: AppColors.textSub.withValues(alpha: 0.5),
                fontSize: 14,
              ),
              prefixIcon: const Icon(Icons.mail_outline, color: AppColors.textSub),
              filled: true,
              fillColor: AppColors.inputBg,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.borderSubtle),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.borderSubtle),
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

          // Field: Password
          const Text(
            "Password",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textSub,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _passwordController,
            obscureText: _isObscurePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password harus diisi";
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Enter your password",
              hintStyle: TextStyle(
                color: AppColors.textSub.withValues(alpha: 0.5),
                fontSize: 14,
              ),
              prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textSub),
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.textSub,
                ),
                onPressed: () {
                  setState(() {
                    _isObscurePassword = !_isObscurePassword;
                  });
                },
              ),
              filled: true,
              fillColor: AppColors.inputBg,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.borderSubtle),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.borderSubtle),
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
          const SizedBox(height: 24),

          // Submit Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryNavy,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 1,
              ),
              onPressed: _isLoading ? null : _submitForm,
              child: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 28),

          // Footer Links
          const Divider(color: AppColors.borderSubtle, height: 1),
          const SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                const Text(
                  "Don't have a PrepMaster account yet?",
                  style: TextStyle(fontSize: 13, color: AppColors.textSub),
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreenDay32(),
                      ),
                    );
                  },
                  child: const Text(
                    "Register Now",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryNavy,
                    ),
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
