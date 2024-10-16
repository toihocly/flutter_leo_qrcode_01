import 'package:flutter/material.dart';
import 'package:flutter_leo_qrcode_01/models/enums/qrcode_type.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'qrcode.dart';

class ContactQRCode extends QRCode {
  final String name;
  final String? phoneNumber;
  final String? email;
  final String? address;
  final String? organization;

  ContactQRCode(
      {required this.name,
      this.phoneNumber,
      this.email,
      this.address,
      this.organization,
      required DateTime createdAt,
      required QRCodeType type})
      : super(_generateData(name, phoneNumber, email, address, organization),
            createdAt, type);

  static String _generateData(String name, String? phoneNumber, String? email,
      String? address, String? organization) {
    // Using vCard format for contact information
    final buffer = StringBuffer()
      ..write('BEGIN:VCARD\n')
      ..write('VERSION:3.0\n')
      ..write('FN:$name\n');

    if (phoneNumber != null) {
      buffer.write('TEL:$phoneNumber\n');
    }
    if (email != null) {
      buffer.write('EMAIL:$email\n');
    }
    if (address != null) {
      buffer.write('ADR:$address\n');
    }
    if (organization != null) {
      buffer.write('ORG:$organization\n');
    }
    buffer.write('END:VCARD');
    return buffer.toString();
  }

  @override
  bool validateData() {
    return name.isNotEmpty; // Name is a required field
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
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
      'organization': organization,
      'createdAt': createdAt.toIso8601String(),
      'type': type.rawValue
    };
  }

  factory ContactQRCode.fromJson(Map<String, dynamic> json) {
    return ContactQRCode(
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        email: json['email'],
        address: json['address'],
        organization: json['organization'],
        createdAt: DateTime.parse(json['createdAt']),
        type: QRCodeType.fromRawValue(json['type']));
  }
}
