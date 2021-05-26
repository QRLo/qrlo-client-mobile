import 'dart:convert';

import 'package:flutter_contacts/contact.dart';
import 'package:injectable/injectable.dart';
import 'package:qrlo_mobile/modules/qrcode/models/business_card.dart';
import 'package:qrlo_mobile/modules/qrcode/ui/preview/qrcode_abstract_preview_view.dart';
import 'package:qrlo_mobile/modules/qrcode/ui/preview/qrcode_business_card_preview_view.dart';
import 'package:qrlo_mobile/modules/qrcode/ui/preview/qrcode_generic_preview_view.dart';

@injectable
class QRCodeSaveAdapter {
  static QRCodeAbstractPreviewView adaptQRCodeSaveView(String rawData) {
    if (rawData.startsWith("BEGIN:VCARD")) {
      final vCard = Contact.fromVCard(rawData);

      final businessCardIdRegex = RegExp(r"QBCID:(.+)\n");
      final businessCardId = businessCardIdRegex.firstMatch(rawData)!.group(1);

      final businessCardUserIdRegex = RegExp(r"QBCUID:(.+)\n");
      final businessCardUserId =
          businessCardUserIdRegex.firstMatch(rawData)!.group(1);
      print(
          "Detected Qrlo BusinessCard with id: $businessCardId, userId: $businessCardUserId");
    }

    try {
      var jsonData = jsonDecode(rawData);

      try {
        return QRCodeBusinessCardPreviewView(
          data: BusinessCard.fromJson(jsonData),
        );
      } catch (e) {
        print("Not a business card");
      }
      return QRCodeGenericPreivewView(
        data: rawData,
      );
    } on FormatException {
      return QRCodeGenericPreivewView(
        data: rawData,
      );
    }
  }
}
