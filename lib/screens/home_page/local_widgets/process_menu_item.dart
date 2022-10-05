import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../styles/layout.dart';
import '../../../theme/app_theme.dart';
import '../../process_page/process_page.dart';

Widget processMenuItem(String itemProcess) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(
      0,
      0,
      0,
      Layout.appSpacing / 2,
    ),
    child: ListTile(
      onTap: () {
        Get.to(() => ProcessPage(status: itemProcess));
      },
      leading: Ink(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Layout.appRadius)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Layout.appSpacing / 4),
          child: Image(
            image: AssetImage('./assets/icons/${itemProcess.toLowerCase()}.png'),
            height: Layout.appSpacing * 2,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        textScaleFactor: 0.8,
        itemProcess,
        style: Theme.of(Get.context!).textTheme.headline6,
      ),
      trailing: const Icon(
        Icons.navigate_next,
      ),
    ),
  );
}
