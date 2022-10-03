import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../styles/palette.dart';
import '../../../styles/style.dart';

Widget loginTitle(String text) {
  return Padding(
    padding: const EdgeInsets.all(Style.appSpacing),
    child: Text(
      'Login',
      style: Theme.of(Get.context!).textTheme.headline3!.copyWith(
            color: Palette.palette[100],
            fontWeight: FontWeight.bold,
          ),
    ),
  );
}
