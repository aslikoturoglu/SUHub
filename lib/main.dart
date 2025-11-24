import 'package:flutter/material.dart';
import 'routes.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(const SUHubApp());
}

class SUHubApp extends StatelessWidget {
  const SUHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SUHub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.welcome,
      routes: AppRoutes.routes,
    );
  }
}