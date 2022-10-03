import 'package:flutter/material.dart';

import '../../../models/process.dart';
import '../../../theme/layout.dart';
import '../../../widgets/card_title.dart';
import 'process_menu_item.dart';

Widget processCard() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(
      0,
      Layout.appSpacing,
      0,
      0,
    ),
    child: Card(
      elevation: Layout.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Layout.appRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          Layout.appSpacing,
          0,
          Layout.appSpacing,
          Layout.appSpacing,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cardTitle('Process'),
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
