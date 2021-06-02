import 'package:flutter_contacts/contact.dart';
import 'package:injectable/injectable.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
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
        print(vCard);
        final businessCardIdRegex = RegExp(r"UID:(.+)\n");
        final businessCardId =
            businessCardIdRegex.firstMatch(rawData)!.group(1);
        if (businessCardId != null) {
          return QRCodeBusinessCardPreviewView(
            data: await getIt<BusinessCardService>().getBusinessCardById(
              int.parse(businessCardId),
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
