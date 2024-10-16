import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_leo_qrcode_01/helpers/utility_helper.dart';
import 'package:flutter_leo_qrcode_01/models/enums/qrcode_type.dart';
import 'package:flutter_leo_qrcode_01/models/qrcode.dart';

import '../components/my_section.dart';
import '../components/my_section_data_item.dart';

class MyHistoryDetail extends StatelessWidget {
  const MyHistoryDetail({super.key, required this.qrCodes});
  final QRCode qrCodes;

  void _handleCopy(BuildContext context) async {
    final String textToCopy = qrCodes.data;
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
                  title: qrCodes.data,
                  onTap: () {
                    if (qrCodes.type != QRCodeType.contactInfo) {
                      UtilityHelper.launchLink(Uri.parse(
                          'https://www.google.com/search?q=${qrCodes.data}'));
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
                    UtilityHelper.shareText(qrCodes.data);
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
