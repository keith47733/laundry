import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../styles/palette.dart';
import '../../../styles/style.dart';
import '../../process_page/process_page.dart';

Widget processMenuItem(String itemProcess) {

	return Padding(
    padding: const EdgeInsets.fromLTRB(
      0,
      0,
      0,
      Style.appSpacing / 2,
    ),
    child: ListTile(
      onTap: () {
                    Get.to(() => ProcessPage(status: itemProcess));
                  },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Style.appRadius),
      ),
      tileColor: Palette.palette[200],
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(Style.appRadius),
        child: Image(
          image: AssetImage('./assets/icons/${itemProcess.toLowerCase()}.png'),
          height: Style.appSpacing * 2,
          fit: BoxFit.cover,
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
