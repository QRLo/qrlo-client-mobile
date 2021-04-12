import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:qrlo_mobile/modules/qrcode/models/business_card.dart';
import 'package:qrlo_mobile/modules/qrcode/ui/preview/qrcode_abstract_preview_view.dart';
import 'package:qrlo_mobile/modules/qrcode/ui/preview/qrcode_business_card_preview_view.dart';
import 'package:qrlo_mobile/modules/qrcode/ui/preview/qrcode_generic_preview_view.dart';

@injectable
class QRCodeSaveAdapter {
  QRCodeAbstractPreviewView adaptQRCodeSaveView(String rawData) {
    try {
      var jsonData = jsonDecode(rawData);
      String type = jsonData['type'];
      switch (type) {
        case 'businesscard':
          return QRCodeBusinessCardPreviewView(
            data: BusinessCard.fromJson(jsonData),
          );
        default:
          return QRCodeGenericPreivewView(
            data: rawData,
          );
      }
    } on FormatException {
      return QRCodeGenericPreivewView(
        data: rawData,
      );
    }
  }
}
