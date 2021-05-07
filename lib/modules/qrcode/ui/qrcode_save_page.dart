import 'package:flutter/material.dart';
import 'package:qrlo_mobile/modules/qrcode/ui/preview/qrcode_abstract_preview_view.dart';

class QRCodeSavePage extends StatelessWidget {
  final QRCodeAbstractPreviewView qrCodeSaveView;

  QRCodeSavePage({required this.qrCodeSaveView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(qrCodeSaveView.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            tooltip: 'Save QR Code',
            onPressed: () {},
          ),
        ],
      ),
      body: qrCodeSaveView.build(context),
    );
  }
}
