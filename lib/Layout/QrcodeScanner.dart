// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import, unused_import, deprecated_member_use

import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({Key? key}) : super(key: key);

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  final GlobalKey qrkey = GlobalKey(debugLabel: 'QrScanner');
  Barcode? result;
  QRViewController? controller;
  @override
  void reassemble() {
    super.reassemble();

    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QrCodeScanner'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrkey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          SingleChildScrollView(
            child: Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        controller?.flipCamera();
                      });
                    },
                    child: Text('Flip The Camera')),
                SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        controller?.toggleFlash();
                      });
                    },
                    child: Text('Open The Flash')),
                SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: InkWell(
                    child: (result != null) ? Text(' Open') : Text('Scan'),
                    onTap: () => launch('${result!.code}'),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Center(
              child: (InkWell(
                child: (result != null)
                    ? Text('Click To the Above Button')
                    : Text('Scan a Code'),
                onTap: () => launch('${result!.code}'),
              )),
            ),
          ),
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
    controller?.dispose();
    super.dispose();
  }
}
