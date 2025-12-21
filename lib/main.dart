import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'providers/event_provider.dart';
import 'providers/preferences_provider.dart';
import 'routes.dart';
import 'services/auth_service.dart';
import 'services/preferences_service.dart';
import 'services/event_repository.dart';
import 'theme/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const SUHubApp());
}

class SUHubApp extends StatelessWidget {
  const SUHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(AuthService()),
        ),

        // Auth değişince EventProvider user’a göre query yapsın
        ChangeNotifierProxyProvider<AuthProvider, EventProvider>(
          create: (_) => EventProvider(EventRepository()),
          update: (_, auth, events) {
            final provider = events ?? EventProvider(EventRepository());
            provider.bindUser(auth.user?.uid);
            return provider;
          },
        ),

        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(PreferencesService())..load(),
        ),
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, prefs, _) {
          return MaterialApp(
            title: 'SUHub',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: AppColors.primary,
              useMaterial3: true,
              // Eğer theme preference yapıyorsan burayı bağlayacağız:
              // brightness: prefs.isDarkMode ? Brightness.dark : Brightness.light,
            ),
            initialRoute: AppRoutes.root,
            routes: AppRoutes.routes,
          );
        },
      ),
    );
  }
}
