import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/modules/auth/services/auth_service.dart';

enum AuthStateEnum {
  NEED_LOGIN,
  FETCHING,
  AUTHENTICATED,
  REGISTRAION_REQUIRED,
  REGISTRATION_FAILED
}

class AuthState extends ChangeNotifier {
  AuthStateEnum currentState = AuthStateEnum.NEED_LOGIN;
  AuthService get _authService => getIt<AuthService>();

  AuthState() {
    refreshToken();
  }

  Future<void> loginWithKakao() async {
    currentState = AuthStateEnum.FETCHING;
    notifyListeners();
    try {
      await _authService.loginWithKakao();
      currentState = AuthStateEnum.AUTHENTICATED;
    } on DioError catch (e) {
      switch (e.response!.statusCode) {
        case HttpStatus.notFound:
          {
            currentState = AuthStateEnum.REGISTRAION_REQUIRED;
            break;
          }
        case HttpStatus.unauthorized:
        default:
          {
            currentState = AuthStateEnum.NEED_LOGIN;
            break;
          }
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void> integrateWithOAuth(String email) async {
    currentState = AuthStateEnum.FETCHING;
    notifyListeners();
    try {
      await _authService.integrateWithOAuth(email);
      currentState = AuthStateEnum.AUTHENTICATED;
    } on DioError {
      currentState = AuthStateEnum.REGISTRATION_FAILED;
    } finally {
      notifyListeners();
    }
  }

  Future<void> logOut() async {
    currentState = AuthStateEnum.FETCHING;
    notifyListeners();
    await _authService.logOut();
    currentState = AuthStateEnum.NEED_LOGIN;
    notifyListeners();
  }

  Future<void> refreshToken() async {
    currentState = AuthStateEnum.FETCHING;
    notifyListeners();
    try {
      await _authService.requestQrloAuthFromStorage();
      currentState = AuthStateEnum.AUTHENTICATED;
    } on DioError catch (e) {
      switch (e.response!.statusCode) {
        case HttpStatus.notFound:
        case HttpStatus.unauthorized:
        default:
          {
            currentState = AuthStateEnum.NEED_LOGIN;
            break;
          }
      }
    } finally {
      notifyListeners();
    }
  }
}
