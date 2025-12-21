import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/preferences_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../routes.dart';
import '../widgets/auth_required.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final auth = context.watch<AuthProvider>();
    final prefs = context.watch<PreferencesProvider>();
    final currentIndex = prefs.loaded ? prefs.lastTabIndex : 0;

    if (!auth.isLoggedIn) {
      return const AuthRequired();
    }

    final categories = <String>[
      'Events',
      'Top Posts of Today',
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          prefs.setLastTab(index);
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, AppRoutes.categories);
              break;
            case 1:
              Navigator.pushReplacementNamed(context, AppRoutes.home);
              break;
            case 2:
              Navigator.pushReplacementNamed(context, AppRoutes.profile);
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),

      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Image.asset(
                      'assets/images/logo.png',
                      height: 48,
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.98),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                        color: Colors.blue.shade200,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),


                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.22),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Column(
                    children: [
                      for (int i = 0; i < categories.length; i++) ...[
                        ListTile(
                          title: Text(
                            categories[i],
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 18,
                            color: Colors.blue.shade700,
                          ),
                          onTap: () {
                            if (categories[i] == 'Events'){
                              Navigator.pushNamed(context, AppRoutes.events);
                            }
                            if (categories[i] == 'Top Posts of Today'){
                              Navigator.pushNamed(context, AppRoutes.topPosts);
                            }
                          },
                        ),
                        if (i != categories.length - 1)
                          Divider(
                            height: 0,
                            thickness: 1,
                            color: Colors.black.withOpacity(0.08),
                            indent: 16,
                            endIndent: 16,
                          ),
                      ]
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
