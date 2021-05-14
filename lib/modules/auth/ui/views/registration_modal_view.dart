import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrlo_mobile/modules/auth/states/auth_state.dart';

class RegistrationModalView extends StatefulWidget {
  const RegistrationModalView({
    required Key key,
  }) : super(key: key);

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
    return SingleChildScrollView(
      child: Form(
        key: widget.key,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 30,
                width: double.infinity,
                child: Center(
                  child: Text(
                    "계정 생성",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
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
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("이메일 인증", style: TextStyle(fontSize: 20)),
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
                    context
                        .read<AuthState>()
                        .integrateWithOAuth(emailController.text);
                    Navigator.of(context).pop();
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    child: Text("건너뛰기", style: TextStyle(fontSize: 20)),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey[800]!),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(color: Colors.red)))),
                    onPressed: () => null),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
