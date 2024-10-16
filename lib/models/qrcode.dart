import 'package:flutter/material.dart';
import 'package:flutter_leo_qrcode_01/models/enums/qrcode_type.dart';

abstract class QRCode {
  String data;
  DateTime createdAt;
  QRCodeType type;

  QRCode(this.data, this.createdAt, this.type);

  // Method to generate the QR code
  Widget generateQRCode();

  // Optionally, validate the data format for specific QR codes
  bool validateData();

  // Convert to JSON
  Map<String, dynamic> toJson();
}
