import 'package:flutter/material.dart';
import 'package:qrlo_mobile/modules/qrcode/models/business_card.dart';
import 'package:qrlo_mobile/modules/qrcode/ui/preview/qrcode_abstract_preview_view.dart';

class QRCodeBusinessCardPreviewView extends QRCodeAbstractPreviewView {
  final BusinessCard data;

  const QRCodeBusinessCardPreviewView({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(data.imageUrl);
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
                  Image.network(data.imageUrl),
                  Card(
                    child: ListTile(
                      title: Text('First Name: ${data.firstName}'),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Last Name: ${data.lastName}'),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Phone Number: ${data.phoneNumber}'),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Email: ${data.email}'),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {},
                      ),
                    ),
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
}
