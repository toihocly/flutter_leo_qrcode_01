import 'package:flutter/material.dart';
import 'package:flutter_leo_qrcode_01/components/my_scanner.dart';
import 'package:flutter_leo_qrcode_01/models/enums/qrcode_type.dart';
import 'package:flutter_leo_qrcode_01/models/text_qrcode.dart';
import 'package:flutter_leo_qrcode_01/persistence/qrcode_persistence.dart';

class MyScanPage extends StatefulWidget {
  const MyScanPage({super.key});

  @override
  State<MyScanPage> createState() => _MyScanPageState();
}

class _MyScanPageState extends State<MyScanPage> {
  QRCodePersistence qrCodePersistence = QRCodePersistence();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var a = TextQRCode("heelo 123123", DateTime.now(), QRCodeType.text);
    var b = TextQRCode("Hello 423424", DateTime.now(), QRCodeType.text);
    var c = TextQRCode("Hello hello", DateTime.now(), QRCodeType.text);

    qrCodePersistence.saveQRCode("0", a);
    qrCodePersistence.saveQRCode("1", b);
    qrCodePersistence.saveQRCode("2", c);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QRCode"),
        centerTitle: true,
      ),
      body: const MyScanner(),
    );
  }
}
