import 'dart:convert';

import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/config/routes_manager.dart';
import 'package:qrlo_mobile/modules/dashboard/states/bottom_navigation_state.dart';
import 'package:qrlo_mobile/modules/qrcode/routes/qrcode_save_route.dart';
import 'package:qrlo_mobile/modules/qrcode/ui/preview/qrcode_abstract_preview_view.dart';
import 'package:qrlo_mobile/modules/qrcode/ui/qrcode_save_adapter.dart';
import 'package:qrlo_mobile/modules/qrcode/ui/exceptions/qrcode_not_existent_exception.dart';

class QRCodeScanView extends StatefulWidget {
  QRCodeScanView({Key key}) : super(key: key);

  @override
  _QRCodeScanViewState createState() => _QRCodeScanViewState();
}

class _QRCodeScanViewState extends State<QRCodeScanView> {
  String barcode = "";
  bool isDenied = false;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isDenied) {
      scan(context);
    }

    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Future scan(BuildContext context) async {
    try {
      String barcode = await BarcodeScanner.scan();
      QRCodeAbstractPreviewView qrCodeSaveView =
          getIt<QRCodeSaveAdapter>().adaptQRCodeSaveView(barcode);
      await getIt<RoutesManager>().router.navigateTo(
            context,
            QRCodeSaveRoute().url,
            routeSettings: RouteSettings(
              arguments: qrCodeSaveView,
            ),
          );
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          isDenied = true;
        });
      } else {
        Provider.of<BottomNavigationState>(context, listen: false)
            .navigateTo(NavigationTab.profile.index);
      }
    } on FormatException {
      print("Format Exception");
      bool shouldRetry = await _showFormatExceptionDialog(context);
      print(shouldRetry);
      if (shouldRetry) {
        return scan(context);
      } else {
        Provider.of<BottomNavigationState>(context, listen: false).pop();
      }
    } on QRCodeNotExistentException {
      print("Format Exception");
      bool shouldRetry = await _showFormatExceptionDialog(context);
      print(shouldRetry);
      if (shouldRetry) {
        return scan(context);
      } else {
        Provider.of<BottomNavigationState>(context, listen: false).pop();
      }
    } catch (e) {
      Provider.of<BottomNavigationState>(context, listen: false)
          .navigateTo(NavigationTab.profile.index);
      print('Unknown error: $e');
    }
  }

  Future<bool> _showFormatExceptionDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("QR 코드 인식 실패"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('QR 코드 인식에 실패했습니다.'),
                Text('다시 시도하시겠습니까?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('취소'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text('재시도'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
  }
}
