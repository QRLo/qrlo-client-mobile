import 'dart:convert';
import 'dart:io';

// import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/config/routes_manager.dart';
import 'package:qrlo_mobile/modules/dashboard/states/bottom_navigation_state.dart';
import 'package:qrlo_mobile/modules/qrcode/routes/qrcode_save_route.dart';
import 'package:qrlo_mobile/modules/qrcode/ui/preview/qrcode_abstract_preview_view.dart';
import 'package:qrlo_mobile/modules/qrcode/ui/qrcode_save_adapter.dart';
import 'package:qrlo_mobile/modules/qrcode/ui/exceptions/qrcode_not_existent_exception.dart';

class QRCodeScanView extends StatefulWidget {
  @override
  _QRCodeScanViewState createState() => _QRCodeScanViewState();
}

class _QRCodeScanViewState extends State<QRCodeScanView> {
  Barcode? result;
  late QRViewController controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: GlobalKey(debugLabel: "QR"),
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                      'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  : Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future scan(BuildContext context) async {
    try {
      QRCodeAbstractPreviewView qrCodeSaveView =
          QRCodeSaveAdapter.adaptQRCodeSaveView(barcode);
      await getIt<RoutesManager>().router.navigateTo(
            context,
            QRCodeSaveRoute().url,
            routeSettings: RouteSettings(
              arguments: qrCodeSaveView,
            ),
          );
    } on PlatformException catch (e) {
      Provider.of<BottomNavigationState>(context, listen: false)
          .navigateTo(NavigationTab.profile.index);
    } on FormatException {
      print("Format Exception");
      bool? shouldRetry = await _showFormatExceptionDialog(context);
      print(shouldRetry);
      if (shouldRetry!) {
        return scan(context);
      } else {
        Provider.of<BottomNavigationState>(context, listen: false).pop();
      }
    } on QRCodeNotExistentException {
      print("Format Exception");
      bool? shouldRetry = await _showFormatExceptionDialog(context);
      print(shouldRetry);
      if (shouldRetry!) {
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

  Future<bool?> _showFormatExceptionDialog(BuildContext context) async {
    return showDialog<bool>(
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
