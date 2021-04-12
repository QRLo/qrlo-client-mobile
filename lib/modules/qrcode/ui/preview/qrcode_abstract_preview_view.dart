import 'package:flutter/material.dart';

abstract class QRCodeAbstractPreviewView extends StatelessWidget {
  const QRCodeAbstractPreviewView({Key key}) : super(key: key);

  get title;
  get data;
}
