// lib/screens/top_post_detail_screen.dart

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class TopPostDetailScreen extends StatefulWidget {
  const TopPostDetailScreen({super.key});

  @override
  State<TopPostDetailScreen> createState() => _TopPostDetailScreenState();
}

class _TopPostDetailScreenState extends State<TopPostDetailScreen> {
  final TextEditingController _commentCtrl = TextEditingController();

  final List<Map<String, String>> _comments = [
    {'user': 'userAgree', 'text': 'yes'},
    {'user': 'userAgree', 'text': 'yes'},
    {
      'user': 'userAgree',
      'text': 'yes yes yes yes yes yes yes and yes',
    },
    {'user': 'userAgree', 'text': 'yes'},
  ];

  @override
  void dispose() {
    _commentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Top Posts of Today',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Image.asset(
                      'assets/images/logo.png',
                      height: 48,
                    ),
                  ],
                ),
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  label: const Text('Back', style: AppTextStyles.bodyWhite),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Post kartı (ladyinfo postu)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding:
                        const EdgeInsets.fromLTRB(12, 10, 12, 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 18,
                                  child: Icon(Icons.person),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'ladyinfo',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Text(
                                      'Other',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const _IconWithCount(
                                    icon: Icons.thumb_up_alt_rounded,
                                    count: 43),
                                SizedBox(width: 8),
                                const _IconWithCount(
                                    icon: Icons.thumb_down_alt_rounded,
                                    count: 12),
                                SizedBox(width: 8),
                                const _IconWithCount(
                                    icon: Icons.chat_bubble_outline_rounded,
                                    count: 23),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'University Center was full today. '
                                  'I couldn’t find any seat!!!',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Comments
                      for (final c in _comments) ...[
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${c['user']}: ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue,
                                    fontSize: 14,
                                  ),
                                ),
                                TextSpan(
                                  text: c['text'],
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),

              // Comment bar
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: TextField(
                      controller: _commentCtrl,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon:
                        Icon(Icons.chat_bubble_outline_rounded),
                        hintText: 'Do you want to add a comment?',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconWithCount extends StatelessWidget {
  final IconData icon;
  final int count;

  const _IconWithCount({required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.blue),
        const SizedBox(width: 2),
        Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 12,
            color: Colors.blue,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
