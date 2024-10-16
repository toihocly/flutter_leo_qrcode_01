import 'package:flutter/material.dart';
import 'package:flutter_leo_qrcode_01/constants/constraint_size.dart';
import 'package:flutter_leo_qrcode_01/constants/icon_size.dart';
import 'package:flutter_leo_qrcode_01/helpers/utility_helper.dart';
import 'package:flutter_leo_qrcode_01/models/qrcode.dart';

class SettingsHistoryItem extends StatelessWidget {
  final IconData? icon;
  final QRCode qrCode;
  final VoidCallback onTap;

  SettingsHistoryItem({this.icon, required this.qrCode, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var leadingWidget = icon != null
        ? Icon(icon, color: Theme.of(context).colorScheme.primary)
        : null;

    return Column(
      children: [
        ListTile(
          leading: leadingWidget,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                UtilityHelper.formatCustomDateTime(qrCode.createdAt),
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              Text(
                qrCode.data,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            ],
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            size: IconSizes.xsmall,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onTap: onTap,
        ),
        Divider(
          height: 0.5,
          thickness: 0.5,
          indent: ConstraintSize.leadingTraing,
          endIndent: 0,
          color: Theme.of(context).dividerColor,
        )
      ],
    );
  }
}
