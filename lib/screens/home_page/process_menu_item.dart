import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/process.dart';
import '../../styles/layout.dart';
import '../../styles/app_theme.dart';
import '../process_page/process_page.dart';

Widget processMenuItem(int statusIndex) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: Layout.SPACING / 2),
    child: ListTile(
      onTap: () {
        Get.to(() => ProcessPage(status: statusIndex));
      },
      contentPadding: const EdgeInsets.symmetric(
        vertical: Layout.SPACING / 3,
        horizontal: Layout.SPACING,
      ),
      tileColor: lighten(color2, 45),
      dense: true,
      leading: Image(
        image: AssetImage(
            './assets/icons/laundry${(statusIndex + 1).toString()}.png'),
        fit: BoxFit.cover,
      ),
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: Layout.SPACING),
        child: Text(
          Process.STATUS_DESC[statusIndex],
          style: Theme.of(Get.context!).textTheme.bodyMedium,
        ),
      ),
      trailing: const Icon(
        Icons.navigate_next,
      ),
    ),
  );
}
