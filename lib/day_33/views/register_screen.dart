import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ppkd_b7/day_20/constants/app_colors.dart';
import 'package:ppkd_b7/day_33/services/api_services.dart';
import 'package:ppkd_b7/day_33/services/dio_client.dart';
import 'package:ppkd_b7/day_33/services/token_storage.dart';
import 'package:ppkd_b7/day_33/views/home_screen.dart';
import 'package:ppkd_b7/day_33/views/login_screen.dart';
import 'package:ppkd_b7/extension/navigator.dart';

class RegisterScreenDay32 extends StatefulWidget {
  RegisterScreenDay32({super.key});

  @override
  State<RegisterScreenDay32> createState() => _RegisterScreenDay32State();
}

class _RegisterScreenDay32State extends State<RegisterScreenDay32> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isObscurePassword = true;
  bool _agreeToTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Harap setujui Syarat dan Ketentuan terlebih dahulu."),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final dio = createDioClient();
      final apiService = ApiService(dio);

      final response = await apiService.register({
        "name": _nameController.text.trim(),
        "email": _emailController.text.trim(),
        "password": _passwordController.text,
      });

      if (!mounted) return;
      TokenStorage.saveToken(response.data?.token ?? "");
      setState(() {
        _isLoading = false;
      });

      _showSuccessDialog(response.message ?? "Registration Successful");
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

  void _showSuccessDialog([String message = "Registration Successful"]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.all(28.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: AppColors.successBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.task_alt,
                    color: AppColors.successGreen,
                    size: 40,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMain,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "We've sent a verification link to your email. Check your inbox to begin your first diagnostic test.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSub,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 24),
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
                      context.pushAndRemoveAll(HomeScreenDay33());
                    },
                    child: Text(
                      "Go to Dashboard",
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
        title: Row(
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
        actions: [
          if (isDesktop) ...[
            TextButton(
              onPressed: () {},
              child: Text(
                "Study Guide",
                style: TextStyle(color: AppColors.textSub),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Test Centers",
                style: TextStyle(color: AppColors.textSub),
              ),
            ),
            SizedBox(width: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryNavy,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: () {},
              child: Text("Login", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(width: 16),
          ],
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 32 : 16,
            vertical: 24,
          ),
          child: Container(
            // maxWidth: isDesktop ? 1000 : 480,
            decoration: BoxDecoration(
              color: AppColors.cardSurface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderSubtle, width: 1),
              boxShadow: [
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
                            padding: EdgeInsets.all(40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Master your future with the official TOEFL Prep.",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        height: 1.3,
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      "Join 50,000+ students achieving their target scores through scaffolded micro-learning and expert-designed diagnostic matrices.",
                                      style: TextStyle(
                                        color: Color(0xFFDCE1FF),
                                        fontSize: 14,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 32),
                                Column(
                                  children: [
                                    _buildFeatureItem(
                                      icon: Icons.verified,
                                      title: "ETS-Aligned Standards",
                                      subtitle:
                                          "Curriculum updated for the 2024 exam format.",
                                    ),
                                    SizedBox(height: 16),
                                    _buildFeatureItem(
                                      icon: Icons.analytics,
                                      title: "AI Performance Tracking",
                                      subtitle:
                                          "Pinpoint grammar and vocabulary gaps instantly.",
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
                            padding: EdgeInsets.all(40),
                            child: _buildForm(context),
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.all(24),
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
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.navyContainer.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.amberAccent, size: 28),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(color: Color(0xFFB6C4FF), fontSize: 12),
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
          Text(
            "Create your account",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textMain,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Begin your journey to professional certification.",
            style: TextStyle(fontSize: 14, color: AppColors.textSub),
          ),
          SizedBox(height: 28),

          // Field: Full Name
          Text(
            "Full Name",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textSub,
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: _nameController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Nama lengkap harus diisi";
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Enter your full legal name",
              hintStyle: TextStyle(
                color: AppColors.textSub.withOpacity(0.5),
                fontSize: 14,
              ),
              prefixIcon: Icon(Icons.person_outline, color: AppColors.textSub),
              filled: true,
              fillColor: AppColors.inputBg,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.borderSubtle),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.borderSubtle),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppColors.primaryNavy,
                  width: 1.5,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),

          // Field: Institutional Email
          Text(
            "Institutional Email",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textSub,
            ),
          ),
          SizedBox(height: 8),
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
              hintText: "name@university.edu",
              hintStyle: TextStyle(
                color: AppColors.textSub.withOpacity(0.5),
                fontSize: 14,
              ),
              prefixIcon: Icon(Icons.mail_outline, color: AppColors.textSub),
              filled: true,
              fillColor: AppColors.inputBg,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.borderSubtle),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.borderSubtle),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppColors.primaryNavy,
                  width: 1.5,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),

          // Field: Password
          Text(
            "Password",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textSub,
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: _passwordController,
            obscureText: _isObscurePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password harus diisi";
              }
              if (value.length < 8) {
                return "Password minimal 8 karakter";
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "At least 8 characters",
              hintStyle: TextStyle(
                color: AppColors.textSub.withOpacity(0.5),
                fontSize: 14,
              ),
              prefixIcon: Icon(Icons.lock_outline, color: AppColors.textSub),
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
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.borderSubtle),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.borderSubtle),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppColors.primaryNavy,
                  width: 1.5,
                ),
              ),
            ),
          ),
          SizedBox(height: 18),

          // Checkbox: Terms & Privacy
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: _agreeToTerms,
                  activeColor: AppColors.primaryNavy,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  onChanged: (val) {
                    setState(() {
                      _agreeToTerms = val ?? false;
                    });
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSub,
                      height: 1.4,
                    ),
                    children: [
                      TextSpan(text: "I agree to the "),
                      TextSpan(
                        text: "Terms of Service",
                        style: TextStyle(
                          color: AppColors.primaryNavy,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(text: " and "),
                      TextSpan(
                        text: "Privacy Policy",
                        style: TextStyle(
                          color: AppColors.primaryNavy,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(text: " regarding academic data collection."),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),

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
                  ? SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Create Account",
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
          SizedBox(height: 28),

          // Footer Links
          Divider(color: AppColors.borderSubtle, height: 1),
          SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                Text(
                  "Already have a PrepMaster account?",
                  style: TextStyle(fontSize: 13, color: AppColors.textSub),
                ),
                SizedBox(height: 4),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreenDay33(),
                      ),
                    );
                  },
                  child: Text(
                    "Login to Continue",
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
