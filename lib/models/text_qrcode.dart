import 'package:flutter/material.dart';
import 'package:flutter_leo_qrcode_01/models/enums/qrcode_type.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'qrcode.dart';

class TextQRCode extends QRCode {
  TextQRCode(String data, DateTime createdAt, QRCodeType type)
      : super(data, createdAt, type);

  @override
  bool validateData() {
    return data.isNotEmpty;
  }

  @override
  Widget generateQRCode() {
    // Use a package like `qr_flutter` to generate the QR code
    return QrImageView(
      data: data,
      version: QrVersions.auto,
      size: 200.0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'createdAt': createdAt.toIso8601String(),
      'type': type.rawValue
    };
  }

  factory TextQRCode.fromJson(Map<String, dynamic> json) {
    return TextQRCode(json['data'], DateTime.parse(json['createdAt']),
        QRCodeType.fromRawValue(json['type']));
  }
}
