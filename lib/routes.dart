import '/screens/categories_screen.dart';
import '/screens/event_detail_screen.dart';
import '/screens/events_screen.dart';
import '/screens/home_screen.dart';
import '/screens/profile_screen.dart';
import '/screens/signin_screen.dart';
import '/screens/top_post_detail_screen.dart';
import '/screens/top_posts_screen.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/signup_screen.dart';

class AppRoutes {
  static const String welcome = '/';
  static const String signup = '/signup';
  static const String signin = '/signin';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String categories = '/categories';
  static const String events = '/events';
  static const String eventDetail = '/event_detail';
  static const String topPosts = '/top_posts';
  static const String topPostDetail = '/top_post_detail';

  static Map<String, WidgetBuilder> routes = {
    welcome: (_) => const WelcomeScreen(),
    signup: (_) => const SignupScreen(),
    signin: (_) => const SigninScreen(),
    home: (_) => const HomeScreen(),
    profile: (_) => const ProfileScreen(),
    categories: (_) => const CategoriesScreen(),
    events: (_) => const EventsScreen(),
    eventDetail: (_) => const EventDetailScreen(),
    topPosts: (_) => const TopPostsScreen(),
    topPostDetail: (_) => const TopPostDetailScreen(),
  };
}