import 'dart:convert';

import 'package:flutter_contacts/contact.dart';
import 'package:injectable/injectable.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/modules/qrcode/models/user_business_card.dart';
import 'package:qrlo_mobile/modules/qrcode/models/business_card_vcard_data.dart';
import 'package:qrlo_mobile/modules/qrcode/ui/preview/qrcode_abstract_preview_view.dart';
import 'package:qrlo_mobile/modules/qrcode/ui/preview/qrcode_business_card_preview_view.dart';
import 'package:qrlo_mobile/modules/qrcode/ui/preview/qrcode_generic_preview_view.dart';
import 'package:qrlo_mobile/services/business_card_service.dart';

@injectable
class QRCodeSaveAdapter {
  static Future<QRCodeAbstractPreviewView> adaptQRCodeSaveView(
      String rawData) async {
    try {
      if (rawData.startsWith("BEGIN:VCARD")) {
        final vCard = Contact.fromVCard(rawData);
        final businessCardDataRegex = RegExp(r"QBCD:(.+)\n");
        final businessCardData =
            businessCardDataRegex.firstMatch(rawData)!.group(1);
        if (businessCardData != null) {
          BusinessCardVCardData businessCardVcardData =
              BusinessCardVCardData.fromJson(
                  json.decode(utf8.decode(base64.decode(businessCardData))));
          print(
              "Detected Qrlo BusinessCard with ${businessCardVcardData.toJson()}");
          return QRCodeBusinessCardPreviewView(
            data: await getIt<BusinessCardService>().getBusinessCardForUserId(
              businessCardVcardData.id,
              businessCardVcardData.userId,
            ),
          );
        } else {}
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
