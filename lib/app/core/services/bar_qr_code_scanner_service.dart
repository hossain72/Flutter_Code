import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class BarQRCodeScannerService {
  late BuildContext _ctx;
  Function? _onProcessStart;
  Function? _onProcessEnd;
  Function? _onResult;
  bool _enableOpenSettings = true;
  String? _barQrCodeResult;

  ScanFormat _scanFormat = ScanFormat.ALL_FORMATS;

  String _permissionTitleMsg = "";
  String _permissionDescriptionMsg = "";
  String _openSettingBtnText = "";
  String _cancelBtnText = "";

  Future initService({
    required BuildContext context,
    Function? onProcessStart,
    Function? onProcessEnd,
    Function(String?)? onResult,
    scanFormat = ScanFormat.ALL_FORMATS,
    bool enableOpenSettings = true,
    String permissionDialogTitle = "Permissions required",
    String permissionDialogSubTitle =
        "Please grant the required permissions in the app settings to continue.",
    String openSettingBtnText = "Open settings",
    String cancelBtnText = "Cancel",
  }) async {
    _ctx = context;
    _enableOpenSettings = enableOpenSettings;
    _onProcessStart = onProcessStart;
    _onProcessEnd = onProcessEnd;
    _onResult = onResult;
    _scanFormat = scanFormat;
    _permissionTitleMsg = permissionDialogTitle;
    _permissionDescriptionMsg = permissionDialogSubTitle;
    _openSettingBtnText = openSettingBtnText;
    _cancelBtnText = cancelBtnText;
    await requestCamera();
  }

  Future requestCamera() async {
    _onProcessStart?.call();
    PermissionStatus status = await Permission.camera.status;
    debugPrint("camera permission:::::::status====$status");
    if (status.isDenied) {
      status = await Permission.camera.request();
      debugPrint("camera permission:::::::status====$status");
    }

    if (status.isPermanentlyDenied && _enableOpenSettings) {
      await _openDialog();
    }
    if (status.isGranted) {
      await getBarQRCode();
    }

    _onProcessEnd?.call();
  }

  Future _openDialog() async {
    bool result =
        (await _permissionDialog(
          _permissionTitleMsg,
          _permissionDescriptionMsg,
          Colors.grey,
        )) ??
        false;
    if (result) {
      openAppSettings();
    }
  }

  _isTablet(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isTablet = screenWidth > 600 && screenHeight > 600;
    return isTablet;
  }

  Future<dynamic> _permissionDialog(
    String? dialougTitle,
    String? dialougdDscription,
    Color divColor,
  ) async {
    return await showDialog(
      barrierDismissible: false,
      context: _ctx,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: const Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: SizedBox(
            width:
                _isTablet(context)
                    ? MediaQuery.of(context).size.width * .6
                    : MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15),
                  Text(
                    dialougTitle!,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(dialougdDscription!, textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  Divider(height: 1, color: divColor),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: InkWell(
                      highlightColor: Colors.grey[200],
                      onTap: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Center(
                        child: Text(
                          _openSettingBtnText,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(height: 1, color: divColor),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: InkWell(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                      highlightColor: Colors.grey[200],
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Center(
                        child: Text(
                          _cancelBtnText,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future getBarQRCode() async {
    _barQrCodeResult = await SimpleBarcodeScanner.scanBarcode(
      _ctx,
      barcodeAppBar: const BarcodeAppBar(
        appBarTitle: 'Bar Code',
        centerTitle: false,
        enableBackButton: true,
        backButtonIcon: Icon(Icons.arrow_back_ios),
      ),
      isShowFlashIcon: true,
      delayMillis: 500,
      cameraFace: CameraFace.back,
      scanFormat: _scanFormat,
    );
    _onResult?.call(_barQrCodeResult);
  }
}
