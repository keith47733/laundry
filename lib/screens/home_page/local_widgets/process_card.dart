import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/process.dart';
import '../../../styles/style.dart';
import '../../../widgets/card_title.dart';
import '../../process_page/process_page.dart';
import 'process_menu_item.dart';

Widget processCard() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(
      0,
      Style.appSpacing,
      0,
      0,
    ),
    child: Card(
      elevation: Style.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Style.appRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          Style.appSpacing,
          0,
          Style.appSpacing,
          Style.appSpacing,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cardTitle('Process'),
            ...List.generate(
              Process.listMenu.length,
              (index) {
                String status = Process.listMenu[index];
                return processMenuItem(
                  status,
                  () {
                    Get.to(() => ProcessPage(status: status));
                  },
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}
