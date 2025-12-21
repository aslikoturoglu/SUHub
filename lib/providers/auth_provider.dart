import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(this._authService) {
    _authSub = _authService.authChanges.listen((firebaseUser) {
      user = firebaseUser;
      initializing = false;
      notifyListeners();
    });
  }

  final AuthService _authService;
  late final StreamSubscription<User?> _authSub;

  User? user;
  bool initializing = true;
  bool busy = false;
  String? error;

  bool get isLoggedIn => user != null;

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    await _runAuthCall(() => _authService.signUp(
          email: email,
          password: password,
          username: username,
        ));
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _runAuthCall(() => _authService.signIn(
          email: email,
          password: password,
        ));
  }

  Future<void> signOut() async {
    busy = true;
    notifyListeners();
    try {
      await _authService.signOut();
    } finally {
      busy = false;
      notifyListeners();
    }
  }

  Future<void> _runAuthCall(Future<User?> Function() action) async {
    busy = true;
    error = null;
    notifyListeners();
    try {
      await action();
    } on FirebaseAuthException catch (e) {
      error = _friendlyError(e);
    } catch (_) {
      error = 'Unexpected error, please try again.';
    } finally {
      busy = false;
      notifyListeners();
    }
  }

  String _friendlyError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'Email is already registered.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'weak-password':
        return 'Password is too weak.';
      case 'user-not-found':
      case 'wrong-password':
        return 'Invalid email or password.';
      case 'network-request-failed':
        return 'Network error, please check your connection.';
      default:
        return 'Authentication failed (${e.code}).';
    }
  }

  @override
  void dispose() {
    _authSub.cancel();
    super.dispose();
  }
}
