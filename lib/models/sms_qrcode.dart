import 'package:flutter/material.dart';
import 'package:flutter_leo_qrcode_01/models/enums/qrcode_type.dart';
import 'package:flutter_leo_qrcode_01/models/qrcode.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SMSQRCode extends QRCode {
  String message;

  SMSQRCode(String data, this.message, DateTime createdAt, QRCodeType type)
      : super(data, createdAt, type);

  @override
  bool validateData() {
    // Basic phone number validation logic
    return RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(data);
  }

  @override
  Widget generateQRCode() {
    return QrImageView(
      data: "sms:$data?body=$message",
      version: QrVersions.auto,
      size: 200.0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'messsage': message,
      'createdAt': createdAt.toIso8601String(),
      'type': type.rawValue
    };
  }

  factory SMSQRCode.fromJson(Map<String, dynamic> json) {
    return SMSQRCode(
        json['data'],
        json['message'],
        DateTime.parse(json['createdAt']),
        QRCodeType.fromRawValue(json['type']));
  }
}
