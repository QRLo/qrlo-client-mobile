import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_info/device_info.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/config/routes_manager.dart';
import 'package:qrlo_mobile/modules/dashboard/states/bottom_navigation_state.dart';
import 'package:qrlo_mobile/modules/qrcode/models/business_card.dart';
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
  QRViewController? controller;
  late bool isPhysicalDevice;
  final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();

  @override
  void initState() {
    super.initState();
    isPhysicalDevice = false;
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: deviceInfoPlugin.iosInfo,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data is IosDeviceInfo) {
            final IosDeviceInfo iosDeviceInfo = snapshot.data as IosDeviceInfo;
            isPhysicalDevice = iosDeviceInfo.isPhysicalDevice;
          } else if (snapshot.data is AndroidDeviceInfo) {
            final AndroidDeviceInfo androidDeviceInfo =
                snapshot.data as AndroidDeviceInfo;
            isPhysicalDevice = androidDeviceInfo.isPhysicalDevice;
          } else {
            isPhysicalDevice = false;
          }
          if (!isPhysicalDevice && result == null) {
            final businessCard = BusinessCard(
              email: "rollee0429@gmail.com",
              company: "Apple",
              phone: "4388837674",
            );
            Timer(
              Duration(seconds: 2),
              () => onDataRead(Barcode(
                jsonEncode(businessCard.toJson()),
                BarcodeFormat.code128,
                [1, 2],
              )),
            );
          }
          return Scaffold(
            body: Column(
              children: <Widget>[
                isPhysicalDevice
                    ? Expanded(
                        flex: 5,
                        child: QRView(
                          key: GlobalKey(debugLabel: "QR"),
                          onQRViewCreated: _onQRViewCreated,
                        ),
                      )
                    : Container(),
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
        });
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.stopCamera();
      await onDataRead(scanData);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future onDataRead(Barcode data) async {
    try {
      QRCodeAbstractPreviewView qrCodeSaveView =
          QRCodeSaveAdapter.adaptQRCodeSaveView(data.code);
      await getIt<RoutesManager>().router.navigateTo(
            context,
            QRCodeSaveRoute().url,
            routeSettings: RouteSettings(
              arguments: qrCodeSaveView,
            ),
          );
    } on FormatException {
      print("Format Exception");
      bool? shouldRetry = await _showFormatExceptionDialog();
      print(shouldRetry);
      if (!shouldRetry!) {
        Provider.of<BottomNavigationState>(context, listen: false).pop();
      }
    } on QRCodeNotExistentException {
      print("Format Exception");
      bool? shouldRetry = await _showFormatExceptionDialog();
      print(shouldRetry);
      if (!shouldRetry!)
        Provider.of<BottomNavigationState>(context, listen: false).pop();
    } catch (e) {
      Provider.of<BottomNavigationState>(context, listen: false)
          .navigateTo(NavigationTab.profile.index);
      print('Unknown error: $e');
    }
  }

  Future<bool?> _showFormatExceptionDialog() async {
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
