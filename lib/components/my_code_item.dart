import 'package:flutter/material.dart';

import '../constants/icon_size.dart';
import '../helpers/utility_helper.dart';
import '../models/qrcode.dart';

class MyCodeItem extends StatelessWidget {
  MyCodeItem({super.key, required this.qrCode});
  QRCode qrCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.red)),
      // margin: EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: IconSizes.medium,
                width: IconSizes.medium,
                decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).dividerColor)),
                child: Icon(Icons.horizontal_split_rounded)),
            const SizedBox(
              width: 10,
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  UtilityHelper.formatCustomDateTime(qrCode.createdAt),
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                Text(qrCode.data,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
