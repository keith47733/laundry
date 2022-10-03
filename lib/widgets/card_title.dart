import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/layout.dart';

Widget cardTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: Layout.appSpacing),
    child: Text(
      title,
      style: Theme.of(Get.context!).textTheme.headline6,
    ),
  );
}
