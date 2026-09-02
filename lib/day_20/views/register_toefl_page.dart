import 'package:flutter/material.dart';

class RegisterToeflPage extends StatefulWidget {
  const RegisterToeflPage({super.key});

  @override
  State<RegisterToeflPage> createState() => _RegisterToeflPageState();
}

class _RegisterToeflPageState extends State<RegisterToeflPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isObscurePassword = true;
  bool _agreeToTerms = false;
  bool _isLoading = false;

  // Custom Colors from Stitch TOEFL Mastery Design System
  static const Color primaryNavy = Color(0xFF00236F);
  static const Color navyContainer = Color(0xFF1E3A8A);
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color bgSurface = Color(0xFFFAF8FF);
  static const Color cardSurface = Colors.white;
  static const Color textMain = Color(0xFF1A1B21);
  static const Color textSub = Color(0xFF444651);
  static const Color inputBg = Color(0xFFF4F3FA);
  static const Color borderSubtle = Color(0xFFC5C5D3);
  static const Color successGreen = Color(0xFF10B981);
  static const Color successBg = Color(0xFFD1FAE5);
  static const Color accentAmber = Color(0xFFFFDDB8);

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

    // Simulasi proses registrasi
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(color: successBg, shape: BoxShape.circle),
                  child: const Icon(Icons.task_alt, color: successGreen, size: 40),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Registration Successful",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textMain),
                ),
                const SizedBox(height: 10),
                const Text(
                  "We've sent a verification link to your email. Check your inbox to begin your first diagnostic test.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: textSub, height: 1.4),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryNavy,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Go to Dashboard",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
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
      backgroundColor: bgSurface,
      appBar: AppBar(
        backgroundColor: cardSurface,
        elevation: 0.5,
        surfaceTintColor: Colors.transparent,
        title: Row(
          children: const [
            Icon(Icons.school, color: primaryNavy, size: 28),
            SizedBox(width: 8),
            Text(
              "PrepMaster",
              style: TextStyle(color: primaryNavy, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        actions: [
          if (isDesktop) ...[
            TextButton(
              onPressed: () {},
              child: const Text("Study Guide", style: TextStyle(color: textSub)),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Test Centers", style: TextStyle(color: textSub)),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryNavy,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: () {},
              child: const Text("Login", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(width: 16),
          ],
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 32 : 16, vertical: 24),
          child: Container(
            // maxWidth: isDesktop ? 1000 : 480,
            decoration: BoxDecoration(
              color: cardSurface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderSubtle, width: 1),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
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
                            color: primaryNavy,
                            padding: const EdgeInsets.all(40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
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
                                      style: TextStyle(color: Color(0xFFDCE1FF), fontSize: 14, height: 1.5),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 32),
                                Column(
                                  children: [
                                    _buildFeatureItem(
                                      icon: Icons.verified,
                                      title: "ETS-Aligned Standards",
                                      subtitle: "Curriculum updated for the 2024 exam format.",
                                    ),
                                    const SizedBox(height: 16),
                                    _buildFeatureItem(
                                      icon: Icons.analytics,
                                      title: "AI Performance Tracking",
                                      subtitle: "Pinpoint grammar and vocabulary gaps instantly.",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Form Kanan
                        Expanded(
                          child: Padding(padding: const EdgeInsets.all(40), child: _buildForm(context)),
                        ),
                      ],
                    ),
                  )
                : Padding(padding: const EdgeInsets.all(24), child: _buildForm(context)),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({required IconData icon, required String title, required String subtitle}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: navyContainer.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Icon(icon, color: accentAmber, size: 28),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
                ),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(color: Color(0xFFB6C4FF), fontSize: 12)),
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
            "Create your account",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textMain),
          ),
          const SizedBox(height: 6),
          const Text(
            "Begin your journey to professional certification.",
            style: TextStyle(fontSize: 14, color: textSub),
          ),
          const SizedBox(height: 28),

          // Field: Full Name
          const Text(
            "Full Name",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: textSub),
          ),
          const SizedBox(height: 8),
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
              hintStyle: TextStyle(color: textSub.withOpacity(0.5), fontSize: 14),
              prefixIcon: const Icon(Icons.person_outline, color: textSub),
              filled: true,
              fillColor: inputBg,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: borderSubtle),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: borderSubtle),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: primaryNavy, width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Field: Institutional Email
          const Text(
            "Institutional Email",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: textSub),
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
              hintText: "name@university.edu",
              hintStyle: TextStyle(color: textSub.withOpacity(0.5), fontSize: 14),
              prefixIcon: const Icon(Icons.mail_outline, color: textSub),
              filled: true,
              fillColor: inputBg,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: borderSubtle),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: borderSubtle),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: primaryNavy, width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Field: Password
          const Text(
            "Password",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: textSub),
          ),
          const SizedBox(height: 8),
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
              hintStyle: TextStyle(color: textSub.withOpacity(0.5), fontSize: 14),
              prefixIcon: const Icon(Icons.lock_outline, color: textSub),
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: textSub,
                ),
                onPressed: () {
                  setState(() {
                    _isObscurePassword = !_isObscurePassword;
                  });
                },
              ),
              filled: true,
              fillColor: inputBg,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: borderSubtle),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: borderSubtle),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: primaryNavy, width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Checkbox: Terms & Privacy
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: _agreeToTerms,
                  activeColor: primaryNavy,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  onChanged: (val) {
                    setState(() {
                      _agreeToTerms = val ?? false;
                    });
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 12, color: textSub, height: 1.4),
                    children: [
                      TextSpan(text: "I agree to the "),
                      TextSpan(
                        text: "Terms of Service",
                        style: TextStyle(color: primaryNavy, fontWeight: FontWeight.w600),
                      ),
                      TextSpan(text: " and "),
                      TextSpan(
                        text: "Privacy Policy",
                        style: TextStyle(color: primaryNavy, fontWeight: FontWeight.w600),
                      ),
                      TextSpan(text: " regarding academic data collection."),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Submit Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryNavy,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 1,
              ),
              onPressed: _isLoading ? null : _submitForm,
              child: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Create Account",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 28),

          // Footer Links
          const Divider(color: borderSubtle, height: 1),
          const SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                const Text("Already have a PrepMaster account?", style: TextStyle(fontSize: 13, color: textSub)),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Login to Continue",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: primaryNavy),
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
