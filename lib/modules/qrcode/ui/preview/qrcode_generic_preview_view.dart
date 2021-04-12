import 'package:flutter/material.dart';
import 'package:qrlo_mobile/modules/qrcode/ui/preview/qrcode_abstract_preview_view.dart';

class QRCodeGenericPreivewView extends QRCodeAbstractPreviewView {
  final dynamic data;

  QRCodeGenericPreivewView({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text('Generic'),
            Text(data),
          ],
        ),
      ),
    );
  }

  @override
  get title => 'Save QR Code';
}
