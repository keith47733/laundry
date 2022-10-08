import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/process.dart';
import '../../../styles/layout.dart';
import 'process_menu_item.dart';

Widget processCard() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(
      0,
      Layout.appSpacing / 2,
      0,
      0,
    ),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          Layout.appSpacing,
          Layout.appSpacing,
          Layout.appSpacing,
          Layout.appSpacing,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                0,
                0,
                0,
                Layout.appSpacing / 2,
              ),
              child: Text('Process', style: Theme.of(Get.context!).textTheme.bodyLarge),
            ),
            ...List.generate(
              Process.listMenu.length,
              (index) {
                String itemProcess = Process.listMenu[index];
                return processMenuItem(
                  itemProcess,
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}
