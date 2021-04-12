import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:qrlo_mobile/modules/qrcode/ui/preview/qrcode_abstract_preview_view.dart';
import 'package:qrlo_mobile/modules/qrcode/ui/qrcode_save_page.dart';
import 'package:qrlo_mobile/shared/base_route.dart';

class QRCodeSaveRoute extends BaseRoute {
  @override
  Handler generateHandler() {
    return Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        final args = context.settings.arguments as QRCodeAbstractPreviewView;
        return QRCodeSavePage(
          qrCodeSaveView: args,
        );
      },
    );
  }

  @override
  String get url => "/qr-codes/save";
}
