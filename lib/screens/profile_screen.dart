import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // TOP ROW: TITLE + LOGO
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Profile',
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
                const SizedBox(height: 32),

                // PROFILE CARD CONTAINER
                Container(
                  width: size.width * 0.9,
                  padding: const EdgeInsets.fromLTRB(20, 36, 20, 32),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.22),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Column(
                    children: [
                      // AVATAR
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        child: Icon(
                          Icons.person_rounded,
                          size: 90,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      const SizedBox(height: 28),

                      // NAME
                      const Text(
                        'Name Surname',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // USERNAME
                      const Text(
                        '@username_',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // EMAIL
                      const Text(
                        'name.surname@sabanciuniv.edu',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const SizedBox(height: 20),

                      Divider(
                        color: Colors.white.withOpacity(0.6),
                        thickness: 1,
                      ),
                      const SizedBox(height: 20),

                      // SETTINGS OPTIONS
                      _ProfileOption(title: 'Add Birth Date'),
                      _ProfileOption(title: 'Change Username'),
                      _ProfileOption(title: 'Change Profile Picture'),
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

class _ProfileOption extends StatelessWidget {
  final String title;
  const _ProfileOption({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(Icons.add, color: Colors.white, size: 22),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
