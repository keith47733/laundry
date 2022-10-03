import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../styles/palette.dart';
import '../styles/style.dart';

Widget cardTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: Style.appSpacing),
    child: Text(
      title,
      style: Theme.of(Get.context!).textTheme.headline6!.copyWith(color: Palette.palette[600]),
    ),
  );
}
