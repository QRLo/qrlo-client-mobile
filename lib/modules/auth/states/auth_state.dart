import 'package:flutter/material.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/modules/auth/models/auth.dart';
import 'package:qrlo_mobile/modules/auth/services/auth_service.dart';

class AuthState extends ChangeNotifier {
  Auth auth;
  bool isFetching = false;
  bool isAuthenticated = false;
  AuthService get _authService => getIt<AuthService>();

  Future<void> fetchAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    isFetching = true;
    notifyListeners();
  }

  Future<void> loginWithKakao() async {
    this.isFetching = true;
    notifyListeners();
    this.auth = await _authService.loginWithKakao();
    this.isFetching = false;
    notifyListeners();
  }

  void setLoading() {
    this.isFetching = true;
    notifyListeners();
  }

  Future<void> refreshToken() async {
    this.auth = await _authService.refreshToken();
    this.isFetching = false;
    notifyListeners();
  }
}
