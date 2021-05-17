import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/modules/auth/models/user.dart';
import 'package:qrlo_mobile/services/auth_service.dart';
import 'package:qrlo_mobile/services/profile_service.dart';
import 'package:qrlo_mobile/modules/qrcode/models/business_card.dart';

enum AuthStateEnum {
  NEED_LOGIN,
  FETCHING,
  AUTHENTICATED,
  REGISTRAION_REQUIRED,
  REGISTRATION_FAILED,
  VERIFICATION_REQUIRED,
  OTP_FAILED,
  PROFILE_CREATION_REQUIRED,
  PROFILE_CREATION_FAILED,
  AUTHORIZED,
}

class AuthState extends ChangeNotifier {
  AuthStateEnum currentState = AuthStateEnum.NEED_LOGIN;
  User? profile;
  AuthService get _authService => getIt<AuthService>();

  void setLoading() {
    currentState = AuthStateEnum.FETCHING;
    notifyListeners();
  }

  Future<void> loginWithKakao() async {
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
    try {
      await _authService.requestOAuthIntegration(email);
      currentState = AuthStateEnum.VERIFICATION_REQUIRED;
    } on DioError {
      currentState = AuthStateEnum.REGISTRATION_FAILED;
    } finally {
      notifyListeners();
    }
  }

  Future<void> verifyOTP(String otp) async {
    try {
      await _authService.verifyOTP(otp);
      currentState = AuthStateEnum.VERIFICATION_REQUIRED;
    } on DioError {
      currentState = AuthStateEnum.REGISTRATION_FAILED;
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchProfile() async {
    try {
      profile = await getIt<ProfileService>().fetchProfile();
      if (profile?.missingProfile?.fields.length == 0)
        currentState = AuthStateEnum.AUTHORIZED;
      else
        currentState = AuthStateEnum.PROFILE_CREATION_REQUIRED;
    } on DioError {
      currentState = AuthStateEnum.NEED_LOGIN;
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateProfile(String firstName, String lastName) async {
    try {
      profile!.firstName = firstName;
      profile!.lastName = lastName;
      profile = await getIt<ProfileService>().updateProfile(profile!);
      currentState = AuthStateEnum.AUTHORIZED;
    } on DioError catch (e) {
      if (e.response!.statusCode == HttpStatus.forbidden) {
        currentState = AuthStateEnum.PROFILE_CREATION_FAILED;
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void> addBusinessCard({
    required name,
    required position,
    required email,
    required phone,
  }) async {
    try {
      final BusinessCard businessCard = BusinessCard(
        company: name,
        position: position,
        phone: phone,
        email: email,
      );
      final BusinessCard createdBusinessCard =
          await getIt<ProfileService>().addBusinessCard(businessCard);
      profile!.myBusinessCards.add(createdBusinessCard);
    } on DioError catch (e) {} finally {
      notifyListeners();
    }
  }

  Future<void> refreshToken() async {
    try {
      await _authService.requestQrloAuthFromStorage();
      currentState = AuthStateEnum.AUTHENTICATED;
    } catch (e) {
      currentState = AuthStateEnum.NEED_LOGIN;
    } finally {
      notifyListeners();
    }
  }

  void pollVerificationRequest() {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      await _authService.requestQrloAuthFromStorage();
      currentState = AuthStateEnum.AUTHENTICATED;
      timer.cancel();
      notifyListeners();
    });
  }

  Future<void> logOut() async {
    await _authService.logOut();
    currentState = AuthStateEnum.NEED_LOGIN;
    notifyListeners();
  }
}
