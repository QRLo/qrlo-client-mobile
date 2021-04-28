import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/modules/auth/services/auth_service.dart';

class AuthState extends ChangeNotifier {
  bool isFetching = true;
  bool isAuthenticated = false;
  AuthService get _authService => getIt<AuthService>();

  AuthState() {
    refreshToken();
  }

  Future<void> loginWithKakao() async {
    this.isFetching = true;
    notifyListeners();
    try {
      await _authService.loginWithKakao();
      this.isAuthenticated = true;
    } on DioError {
      this.isAuthenticated = false;
    } finally {
      this.isFetching = false;
      notifyListeners();
    }
  }

  Future<void> logOut() async {
    this.isFetching = true;
    this.isAuthenticated = false;
    notifyListeners();
    await _authService.logOut();
    this.isFetching = false;
    notifyListeners();
  }

  Future<void> refreshToken() async {
    this.isFetching = true;
    notifyListeners();
    try {
      await _authService.requestQrloAuthFromStorage();
      this.isAuthenticated = true;
    } on DioError {
      this.isAuthenticated = false;
    } finally {
      this.isFetching = false;
      notifyListeners();
    }
  }
}
