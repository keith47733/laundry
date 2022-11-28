import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/process.dart';
import '../../styles/layout.dart';
import 'process_menu_item.dart';

Widget processCard() {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(Layout.SPACING),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Process',
            style: Theme.of(Get.context!).textTheme.titleMedium,
          ),
          const SizedBox(height: Layout.SPACING / 2),
          ...List.generate(
            Process.STATUS_DESC.length,
            (index) => processMenuItem(index),
          ),
        ],
      ),
    ),
  );
}
