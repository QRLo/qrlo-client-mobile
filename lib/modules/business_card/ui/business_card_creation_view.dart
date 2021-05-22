import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrlo_mobile/modules/profile/states/profile_state.dart';

class BusinessCardCreationView extends StatefulWidget {
  BusinessCardCreationView({required Key key}) : super(key: key);

  @override
  _BusinessCardCreationViewState createState() =>
      _BusinessCardCreationViewState();
}

class _BusinessCardCreationViewState extends State<BusinessCardCreationView> {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyPostiionController = TextEditingController();
  TextEditingController companyEmailController = TextEditingController();
  TextEditingController companyPhoneController = TextEditingController();

  @override
  void dispose() {
    companyEmailController.dispose();
    companyPostiionController.dispose();
    companyNameController.dispose();
    companyPhoneController.dispose();
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
                    "명함 생성",
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
                controller: companyNameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.apartment_rounded),
                  hintText: "회사명",
                ),
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: companyPostiionController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.work),
                  hintText: "직책",
                ),
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: companyEmailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: "회사 이메일",
                ),
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: companyPhoneController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  hintText: "회사 전화번호",
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(color: Colors.red)))),
                    onPressed: () {
                      context.read<ProfileState>()
                        ..addBusinessCard(
                          name: companyNameController.text,
                          position: companyPostiionController.text,
                          email: companyEmailController.text,
                          phone: companyPhoneController.text,
                        );
                      Navigator.of(context).pop();
                    }),
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
                    onPressed: () => Navigator.of(context).pop()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
