import 'package:flutter/material.dart';
import 'package:qrlo_mobile/modules/qrcode/ui/preview/qrcode_abstract_preview_view.dart';

class QRCodeGenericPreivewView extends QRCodeAbstractPreviewView {
  final dynamic data;

  QRCodeGenericPreivewView({required this.data});

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

  @override
  onSave(BuildContext context) {
    print("hello generic save!");
  }
}
