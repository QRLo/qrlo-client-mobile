import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrlo_mobile/modules/auth/services/domains/missing_profile.dart';
import 'package:qrlo_mobile/modules/auth/states/auth_state.dart';

class ProfileCreationModalView extends StatefulWidget {
  final MissingProfile missingProfile;
  ProfileCreationModalView({
    required this.missingProfile,
  });

  @override
  _ProfileCreationModalViewState createState() =>
      _ProfileCreationModalViewState();
}

class _ProfileCreationModalViewState extends State<ProfileCreationModalView> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthState>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 30,
              child: Center(
                  child: Text(
                "프로필 입력",
                style: TextStyle(
                  fontSize: 25,
                ),
              )),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(
                labelText: "성",
              ),
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(
                labelText: "이름",
              ),
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("프로필 생성", style: TextStyle(fontSize: 20)),
                ),
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey[800]!),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.red)))),
                onPressed: () {
                  authState.updateProfile(
                      firstNameController.text, lastNameController.text);
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
