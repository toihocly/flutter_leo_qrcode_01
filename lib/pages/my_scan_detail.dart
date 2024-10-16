import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_leo_qrcode_01/helpers/utility_helper.dart';
import 'package:flutter_leo_qrcode_01/models/enums/qrcode_type.dart';
import 'package:flutter_leo_qrcode_01/models/qrcode.dart';
import 'package:flutter_leo_qrcode_01/models/text_qrcode.dart';
import 'package:flutter_leo_qrcode_01/persistence/qrcode_persistence.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../components/my_section.dart';
import '../components/my_section_data_item.dart';

class MyScannerDetail extends StatefulWidget {
  MyScannerDetail({super.key, required this.qrCodes});
  final List<Barcode> qrCodes;

  @override
  State<MyScannerDetail> createState() => _MyScannerDetailState();
}

class _MyScannerDetailState extends State<MyScannerDetail> {
  QRCodePersistence qrCodePersistence = QRCodePersistence();

  void _handleCopy(BuildContext context) async {
    final String textToCopy = widget.qrCodes.first.rawValue ?? "";
    if (textToCopy.isNotEmpty) {
      try {
        await Clipboard.setData(ClipboardData(text: textToCopy));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Copied to Clipboard!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to copy to clipboard.')),
        );
      }
    }
  }

  void _handleDataStore() {
    BarcodeType barcodeType = widget.qrCodes.first.type;
    QRCode qrCode;
    switch (widget.qrCodes.first.type) {
      case BarcodeType.text:
        qrCode = TextQRCode('${widget.qrCodes.first.rawValue}', DateTime.now(),
            QRCodeType.fromRawValue(widget.qrCodes.first.type.rawValue));
        break;
      default:
        {
          return;
        }
    }
    qrCodePersistence.saveQRCode(
        UtilityHelper.generateRandomString(10), qrCode);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _handleDataStore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            // Data Section
            SettingsSection(
              title: 'Data',
              items: [
                SettingsDataItem(
                  title: "${widget.qrCodes.first.rawValue}",
                  onTap: () {
                    if (widget.qrCodes.first.type != BarcodeType.contactInfo) {
                      UtilityHelper.launchLink(Uri.parse(
                          'https://www.google.com/search?q=${widget.qrCodes.first.rawValue}'));
                    }
                  },
                ),
              ],
            ),
            // Action Section
            SettingsSection(
              title: 'Action',
              items: [
                SettingsDataItem(
                  icon: Icons.file_copy_rounded,
                  title: 'Copy',
                  onTap: () => _handleCopy(context),
                ),
                SettingsDataItem(
                  icon: Icons.ios_share_rounded,
                  title: 'Share to other',
                  onTap: () {
                    UtilityHelper.shareText("${widget.qrCodes.first.rawValue}");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
