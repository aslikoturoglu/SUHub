import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../routes.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    if (auth.initializing) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final targetRoute = auth.isLoggedIn ? AppRoutes.home : AppRoutes.welcome;
      Navigator.of(context).pushNamedAndRemoveUntil(
        targetRoute,
        (route) => false,
      );
    });

    // Bu widget ekranda çok kısa kalır; asıl ekran route ile açılır.
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
