import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_leo_qrcode_01/components/my_section_history_item.dart';
import 'package:flutter_leo_qrcode_01/pages/my_history_detail.dart';
import 'package:flutter_leo_qrcode_01/persistence/qrcode_persistence.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../models/qrcode.dart';

class MyHistoryPage extends StatefulWidget {
  const MyHistoryPage({super.key});

  @override
  State<MyHistoryPage> createState() => _MyHistoryPageState();
}

class _MyHistoryPageState extends State<MyHistoryPage> {
  QRCodePersistence qrCodePersistence = QRCodePersistence();
  List<QRCode> _data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadQRCode();
  }

  void _loadQRCode() async {
    final data = await qrCodePersistence.getAllQRCodes();
    print('yyyyyyyyy');
    print(data.length);
    setState(() {
      _data = data;
    });
  }

  void _hanldeHistoryDetail(QRCode qrCode) {
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: MyHistoryDetail(qrCodes: qrCode),
      withNavBar: false, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("History"),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemBuilder: (content, index) {
            return SettingsHistoryItem(
                icon: Icons.horizontal_split_rounded,
                qrCode: _data[index],
                onTap: () => _hanldeHistoryDetail(_data[index]));
          },
          itemCount: _data.length,
        ));
  }
}
