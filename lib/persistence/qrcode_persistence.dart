import 'dart:convert';

import 'package:flutter_leo_qrcode_01/models/enums/qrcode_type.dart';
import 'package:flutter_leo_qrcode_01/models/text_qrcode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/qrcode.dart';

class QRCodePersistence {
  Future<void> saveQRCode(String key, QRCode qrCode) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(qrCode.toJson());
    await prefs.setString(key, jsonString);
  }

  Future<List<QRCode>> getAllQRCodes() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    List<QRCode> qrCodes = [];

    for (String key in keys) {
      final jsonString = prefs.getString(key);
      if (jsonString != null) {
        try {
          final Map<String, dynamic> json = jsonDecode(jsonString);

          switch (QRCodeType.fromRawValue(json["type"])) {
            case QRCodeType.text:
              QRCode qrCode = TextQRCode.fromJson(json);
              qrCodes.add(qrCode);
              break;
            default:
          }
        } catch (e) {
          print("Error loading QRCode from key $key: $e");
          // Handle any errors that might occur during JSON parsing
        }
      }
    }

    return qrCodes;
  }

  Future<QRCode?> getQRCode(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      final Map<String, dynamic> json = jsonDecode(jsonString);

      switch (json["type"]) {
        case 'text':
          return TextQRCode.fromJson(json);

        default:
      }
    }
    return null;
  }
}
