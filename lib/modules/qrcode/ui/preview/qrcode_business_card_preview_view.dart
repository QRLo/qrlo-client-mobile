import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrlo_mobile/modules/profile/states/profile_state.dart';
import 'package:qrlo_mobile/modules/qrcode/models/user_business_card.dart';
import 'package:qrlo_mobile/modules/qrcode/ui/preview/qrcode_abstract_preview_view.dart';

class QRCodeBusinessCardPreviewView extends QRCodeAbstractPreviewView {
  final UserBusinessCard data;

  QRCodeBusinessCardPreviewView({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraint.maxHeight,
              ),
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.work,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text("${data.lastName}${data.firstName}"),
                    subtitle: Text("이름"),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.apartment_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(data.company),
                    subtitle: Text("회사명"),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.work,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(data.position),
                    subtitle: Text("직책"),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Row(
                      children: [
                        Text(data.email),
                        if (data.emailVerified != null &&
                            data.emailVerified == true)
                          Tooltip(
                            message: "인증되었습니다",
                            child: Icon(
                              Icons.check_circle,
                            ),
                          ),
                      ],
                    ),
                    subtitle: Text("이메일"),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.phone_android,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(data.phone),
                    subtitle: Text("연락처"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  get title => 'Save Business Card';

  @override
  onSave(BuildContext context) {
    context.read<ProfileState>().addContact(data.id!);
    print("hello save!");
  }
}
