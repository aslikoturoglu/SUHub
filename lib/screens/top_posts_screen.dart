import 'package:flutter/material.dart';
import '../routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class TopPostsScreen extends StatelessWidget {
  const TopPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final posts = [
      {
        'username': 'ladyinfo',
        'category': 'Other',
        'text':
        'University Center was full today. I couldn’t find any seat!!!',
        'likes': 43,
        'dislikes': 12,
        'comments': 23,
      },
      {
        'username': 'sabancitiger',
        'category': 'Lessons',
        'text': 'Does anybody have notes for the upcoming Math 102 exam?',
        'likes': 43,
        'dislikes': 12,
        'comments': 23,
      },
      {
        'username': 'hungryGirl',
        'category': 'Food',
        'text':
        'The chicken on Küçükev was pretty good. I just ate one more.',
        'likes': 43,
        'dislikes': 12,
        'comments': 23,
      },
    ];

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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Başlık + logo
                Row(
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
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      label: const Text('Back', style: AppTextStyles.bodyWhite),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.separated(
                    itemCount: posts.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.topPostDetail);
                        },
                        child: Container(
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
                                    children: [
                                      Text(
                                        post['username'] as String,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Text(
                                        post['category'] as String,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  _IconWithCount(
                                    icon: Icons.thumb_up_alt_rounded,
                                    count: post['likes'] as int,
                                  ),
                                  const SizedBox(width: 8),
                                  _IconWithCount(
                                    icon: Icons.thumb_down_alt_rounded,
                                    count: post['dislikes'] as int,
                                  ),
                                  const SizedBox(width: 8),
                                  _IconWithCount(
                                    icon: Icons.chat_bubble_outline_rounded,
                                    count: post['comments'] as int,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                post['text'] as String,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
