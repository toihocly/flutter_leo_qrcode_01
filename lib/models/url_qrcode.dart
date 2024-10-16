import 'package:flutter/material.dart';
import 'package:flutter_leo_qrcode_01/models/enums/qrcode_type.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'qrcode.dart';

class UrlQRCode extends QRCode {
  UrlQRCode(String data, DateTime createdAt, QRCodeType type)
      : super(data, createdAt, type);

  @override
  bool validateData() {
    // Add URL validation logic
    return Uri.tryParse(data)?.hasAbsolutePath ?? false;
  }

  @override
  Widget generateQRCode() {
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

  factory UrlQRCode.fromJson(Map<String, dynamic> json) {
    return UrlQRCode(json['data'], DateTime.parse(json['createdAt']),
        QRCodeType.fromRawValue(json['type']));
  }
}
