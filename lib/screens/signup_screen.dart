import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/preferences_provider.dart';
import '../routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  bool acceptedTerms = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.95),
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.blue.shade200),
      ),
    );
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (!acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You must accept the terms of service.'),
        ),
      );
      return;
    }

    final auth = context.read<AuthProvider>();
    final prefs = context.read<PreferencesProvider>();

    await auth.signUp(
      email: _emailCtrl.text.trim(),
      password: _passwordCtrl.text.trim(),
      username: _usernameCtrl.text.trim(),
    );

    if (!mounted) return;
    if (auth.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(auth.error!)),
      );
      return;
    }

    await prefs.setUsername(_usernameCtrl.text.trim());

    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
    );
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

                        const Text('Username', style: AppTextStyles.bodyWhite),
                        const SizedBox(height: 4),
                        TextFormField(
                          controller: _usernameCtrl,
                          decoration: _inputDecoration(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),

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
                        const SizedBox(height: 18),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Switch(
                              value: acceptedTerms,
                              activeThumbColor: Colors.white,
                              onChanged: (val) {
                                setState(() {
                                  acceptedTerms = val;
                                });
                              },
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'I accept the terms of service and privacy policy',
                                    style: AppTextStyles.bodyWhite,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Click to read the document.',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),

                        Consumer<AuthProvider>(
                          builder: (_, auth, __) {
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: auth.busy ? null : _register,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: auth.busy
                                    ? const SizedBox(
                                        height: 18,
                                        width: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text(
                                        'Register',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 14),

                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Already have an account? ',
                                style: AppTextStyles.bodyWhite,
                              ),
                              GestureDetector(
                                onTap: () =>
                                    Navigator.pushReplacementNamed(
                                        context, AppRoutes.signin),
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
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
        ]
      ),
    );
  }
}
