import 'package:flutter/material.dart';
import '../routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.95),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.blueAccent),
      ),
    );
  }

  void _signIn() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pushReplacementNamed(context, AppRoutes.welcome);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.secondary,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: size.width * 0.87,
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 32),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.22),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/logo.png',
                                height: 100,
                              ),
                              const SizedBox(height: 12),
                              const Text('SUHub', style: AppTextStyles.appTitle),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),

                        // EMAIL
                        const Text('Email', style: AppTextStyles.bodyWhite),
                        const SizedBox(height: 4),
                        TextFormField(
                          controller: _emailCtrl,
                          decoration: _inputDecoration(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            if (!value.contains('@')) {
                              return 'Invalid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),

                        // PASSWORD
                        const Text('Password', style: AppTextStyles.bodyWhite),
                        const SizedBox(height: 4),
                        TextFormField(
                          controller: _passwordCtrl,
                          obscureText: true,
                          decoration: _inputDecoration(),
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return 'At least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),

                        // FORGOT PASSWORD
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // SIGN IN BUTTON
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _signIn,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding:
                              const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // SIGN UP LINK
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Don’t have an account? ',
                                style: AppTextStyles.bodyWhite,
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pushReplacementNamed(
                                    context, AppRoutes.signup),
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
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
              ),
            ),
          ),


          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.welcome);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
