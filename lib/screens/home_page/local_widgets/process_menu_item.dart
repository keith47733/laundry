import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../styles/layout.dart';
import '../../process_page/process_page.dart';

Widget processMenuItem(String itemProcess) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(
      0,
      Layout.appSpacing / 2,
      0,
      Layout.appSpacing / 2,
    ),
    child: ListTile(
      onTap: () {
        Get.to(() => ProcessPage(status: itemProcess));
      },
      leading: Image(
      	image: AssetImage('./assets/icons/${itemProcess.toLowerCase()}.png'),
      	fit: BoxFit.fill,
      ),
      title: Padding(
        padding: const EdgeInsets.fromLTRB(
					0,
					Layout.appSpacing,
					0,
					Layout.appSpacing,
				),
        child: Text(
          itemProcess,
          style: Theme.of(Get.context!).textTheme.bodyMedium,
        ),
      ),
      trailing: const Icon(
        Icons.navigate_next,
      ),
    ),
  );
}
