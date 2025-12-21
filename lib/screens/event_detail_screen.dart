import 'package:flutter/material.dart';

import '../models/app_event.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final event =
        ModalRoute.of(context)?.settings.arguments as AppEvent?;

    return Scaffold(
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event?.title ?? 'Event',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            event?.date ?? '',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/images/logo.png',
                      height: 48,
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.arrow_back, color: Colors.white, size: 20),
                      SizedBox(width: 4),
                      Text(
                        'Geri',
                        style: AppTextStyles.bodyWhite,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  height: 220,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: event?.imageUrl.isNotEmpty == true
                      ? Image.network(event!.imageUrl, fit: BoxFit.cover)
                      : Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.contain,
                        ),
                ),
                const SizedBox(height: 24),

                const Text(
                  'Detaylar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  event?.description.isNotEmpty == true
                      ? event!.description
                      : 'No description provided.',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    height: 1.4,
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
