import 'package:flutter/material.dart';
import 'package:flutter_leo_qrcode_01/components/my_section_data_item.dart';

class SettingsSection extends StatelessWidget {
  final String title;
  final List<SettingsDataItem> items;

  SettingsSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        Column(
          children: items.map((item) => item).toList(),
        ),
      ],
    );
  }
}
