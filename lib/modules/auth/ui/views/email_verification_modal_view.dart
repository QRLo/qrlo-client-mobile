import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrlo_mobile/modules/auth/states/auth_state.dart';

class EmailVerificationView extends StatefulWidget {
  EmailVerificationView({required key}) : super(key: key);
  @override
  _EmailVerificationViewState createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<EmailVerificationView> {
  @override
  void initState() {
    super.initState();
    context.read<AuthState>().pollVerificationRequest();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<AuthState>().currentState ==
        AuthStateEnum.AUTHENTICATED) {
      Future.microtask(() => Navigator.of(context).pop());
    }

    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 40, 40, 80),
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 30,
              child: Center(
                  child: Text(
                "이메일을 확인해주세요",
                style: TextStyle(
                  fontSize: 25,
                ),
              )),
            ),
            SizedBox(
              height: 10,
            ),
            Icon(
              Icons.email,
              size: 80,
            ),
          ],
        ),
      ),
    );
  }
}
