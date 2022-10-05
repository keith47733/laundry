import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../styles/layout.dart';

Widget loginTitle(String text) {
  return Padding(
    padding: const EdgeInsets.all(Layout.appSpacing),
    child: Text(
      'Login',
      style: Theme.of(Get.context!).textTheme.headline3!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    ),
  );
}
