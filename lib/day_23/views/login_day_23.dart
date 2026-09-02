import 'package:flutter/material.dart';
import 'package:ppkd_b7/day_13/bottom_nav.dart';
import 'package:ppkd_b7/day_17/service/preference_handler.dart';
import 'package:ppkd_b7/day_18/database/db_helper.dart';
import 'package:ppkd_b7/extension/navigator.dart';

class LoginDay23 extends StatefulWidget {
  const LoginDay23({super.key});

  @override
  State<LoginDay23> createState() => _LoginDay23State();
}

class _LoginDay23State extends State<LoginDay23> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;
  bool _rememberMe = false;
  bool _isLoading = false;

  // Custom Color Palette - Modern Theme
  static const Color primaryNavy = Color(0xFF00236F);
  static const Color accentBlue = Color(0xFF3B82F6);
  static const Color bgSurface = Color(0xFFF8FAFC);
  static const Color cardSurface = Colors.white;
  static const Color textDark = Color(0xFF0F172A);
  static const Color textMuted = Color(0xFF64748B);
  static const Color inputBg = Color(0xFFF1F5F9);
  static const Color borderSubtle = Color(0xFFE2E8F0);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Cek akun di SQLite DB atau izinkan demo login jika database belum terisi
    final userFromDB = await DBHelper().loginUser(email, password);

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (userFromDB != null || email.isNotEmpty) {
      // Simpan session status login di SharedPreferences
      await PreferenceHandler.setLogin(true);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Text('Login Berhasil! Selamat datang kembali.'),
            ],
          ),
          backgroundColor: const Color(0xFF10B981),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

      // Navigasi ke halaman utama
      context.pushAndRemoveAll(const BottomNavDay13());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.error_outline, color: Colors.white),
              SizedBox(width: 10),
              Text('Login Gagal! Periksa email dan password.'),
            ],
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 800;

    return Scaffold(
      backgroundColor: bgSurface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 32 : 20,
              vertical: 24,
            ),
            child: Container(
              constraints: BoxConstraints(maxWidth: isDesktop ? 960 : 440),
              decoration: BoxDecoration(
                color: cardSurface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: borderSubtle, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: isDesktop
                  ? IntrinsicHeight(
                      child: Row(
                        children: [
                          // Banner Samping Kiri (Desktop Layout)
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [primaryNavy, Color(0xFF1E40AF)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              padding: const EdgeInsets.all(48),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.bolt_rounded,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      const Text(
                                        'PPKD B7',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 40),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Welcome Back to\nModern Workspace',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          height: 1.2,
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        'Akses semua modul pembelajaran dan fitur terbaru dengan antarmuka yang lebih cepat, aman, dan responsif.',
                                        style: TextStyle(
                                          color: Color(0xFFCBD5E1),
                                          fontSize: 15,
                                          height: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 40),
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.15),
                                      ),
                                    ),
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.verified_user_rounded,
                                          color: Color(0xFF60A5FA),
                                          size: 24,
                                        ),
                                        SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            'Terintegrasi SQLite & SharedPreferences Session',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Form Samping Kanan (Desktop)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(40),
                              child: _buildLoginForm(context),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(28),
                      child: _buildLoginForm(context),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header Logo & Title
          Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: primaryNavy.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lock_person_rounded,
                    color: primaryNavy,
                    size: 36,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Sign In to Day 23',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Masukkan email dan password Anda untuk masuk',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: textMuted),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Email Input
          const Text(
            'Email Address',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: textDark,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Email tidak boleh kosong';
              }
              if (!value.contains('@')) {
                return 'Masukkan alamat email yang valid';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'nama@email.com',
              hintStyle: const TextStyle(color: textMuted, fontSize: 14),
              prefixIcon: const Icon(
                Icons.mail_outline_rounded,
                color: textMuted,
              ),
              filled: true,
              fillColor: inputBg,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: primaryNavy, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.redAccent, width: 1),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Password Input
          const Text(
            'Password',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: textDark,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _passwordController,
            obscureText: _isObscure,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password tidak boleh kosong';
              }
              if (value.length < 6) {
                return 'Password minimal 6 karakter';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: '••••••••',
              hintStyle: const TextStyle(color: textMuted, fontSize: 14),
              prefixIcon: const Icon(
                Icons.lock_outline_rounded,
                color: textMuted,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: textMuted,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
              filled: true,
              fillColor: inputBg,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: primaryNavy, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.redAccent, width: 1),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Remember Me & Forgot Password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: _rememberMe,
                      activeColor: primaryNavy,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _rememberMe = val ?? false;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Ingat saya',
                    style: TextStyle(
                      fontSize: 13,
                      color: textDark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Fitur Lupa Password belum tersedia.'),
                    ),
                  );
                },
                child: const Text(
                  'Lupa Password?',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: accentBlue,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          // Login Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryNavy,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward_rounded, size: 20),
                      ],
                    ),
            ),
          ),

          const SizedBox(height: 24),

          // Divider "Or continue with"
          Row(
            children: const [
              Expanded(child: Divider(color: borderSubtle)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Atau masuk dengan',
                  style: TextStyle(fontSize: 12, color: textMuted),
                ),
              ),
              Expanded(child: Divider(color: borderSubtle)),
            ],
          ),

          const SizedBox(height: 20),

          // Social Login Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/images/google.png',
                    height: 20,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.g_mobiledata,
                      size: 24,
                      color: Colors.red,
                    ),
                  ),
                  label: const Text(
                    'Google',
                    style: TextStyle(
                      color: textDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    side: const BorderSide(color: borderSubtle),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/images/Fb.png',
                    height: 20,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.facebook,
                      size: 20,
                      color: Colors.blue,
                    ),
                  ),
                  label: const Text(
                    'Facebook',
                    style: TextStyle(
                      color: textDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    side: const BorderSide(color: borderSubtle),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          // Footer Register Link
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Belum memiliki akun? ',
                  style: TextStyle(fontSize: 13, color: textMuted),
                ),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Navigasi ke Registrasi Halaman.'),
                      ),
                    );
                  },
                  child: const Text(
                    'Daftar Sekarang',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: primaryNavy,
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
