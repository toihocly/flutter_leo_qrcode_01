import 'package:flutter/material.dart';
import 'package:flutter_leo_qrcode_01/models/enums/qrcode_type.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'qrcode.dart';

class EmailQRCode extends QRCode {
  EmailQRCode(String data, DateTime createdAt, QRCodeType type)
      : super(data, createdAt, type);

  @override
  bool validateData() {
    // Basic email validation logic
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(data);
  }

  @override
  Widget generateQRCode() {
    return QrImageView(
      data: "mailto:$data",
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

  factory EmailQRCode.fromJson(Map<String, dynamic> json) {
    return EmailQRCode(json['data'], DateTime.parse(json['createdAt']),
        QRCodeType.fromRawValue(json['type']));
  }
}
