import 'package:flutter/material.dart';

abstract class QRCodeAbstractPreviewView extends StatefulWidget {
  QRCodeAbstractPreviewView({required Key key}) : super(key: key);

  @override
  _QRCodeAbstractPreviewViewState createState() => _QRCodeAbstractPreviewViewState();
}

class _QRCodeAbstractPreviewViewState extends State<QRCodeAbstractPreviewView> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Container(),
    );
  }
} {
  get title;
  get data;
  Function onSave(BuildContext context);
}
