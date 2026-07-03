import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';
import 'dart:async';

class AuthProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = true;
  String? _error;

  late final StreamSubscription _authSubscription;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _initializeAuth();
  }

  void _initializeAuth() {
    // 1. Restore session immediately (critical for APK cold start)
    final session = supabase.auth.currentSession;
    _user = session?.user;

    // mark loading done after first sync
    _isLoading = false;
    notifyListeners();

    // 2. Listen to auth changes
    _authSubscription =
        supabase.auth.onAuthStateChange.listen((data) {
          _user = data.session?.user;
          _isLoading = false;
          notifyListeners();
        });
  }

  Future<void> signInWithGoogle() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'com.example.todoapp://login-callback',
        authScreenLaunchMode: LaunchMode.externalApplication,
      );
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    try {
      _isLoading = true;
      notifyListeners();

      await supabase.auth.signOut();
      _user = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }
}