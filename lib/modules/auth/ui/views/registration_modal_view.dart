import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrlo_mobile/modules/auth/states/auth_state.dart';

class RegistrationModalView extends StatefulWidget {
  RegistrationModalView({required key}) : super(key: key);
  @override
  _RegistrationModalViewState createState() => _RegistrationModalViewState();
}

class _RegistrationModalViewState extends State<RegistrationModalView> {
  TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthState>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 30,
              child: Center(
                  child: Text(
                "계정 생성",
                style: TextStyle(
                  fontSize: 25,
                ),
              )),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
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
                  child: Text("이메일 인증", style: TextStyle(fontSize: 20)),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  authState.integrateWithOAuth(emailController.text);
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
