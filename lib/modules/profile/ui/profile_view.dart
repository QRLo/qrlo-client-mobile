import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/modules/profile/services/profile_service.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getIt<ProfileService>().fetchProfile();
    return SingleChildScrollView(
      child: Container(
        child: Text('Profile'),
      ),
    );
  }
}
