// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:qrcodescanner/Layout/QrcodeScanner.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QrCodeScanner(),
      debugShowCheckedModeBanner: false,
    );
  }
}
