import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../styles/palette.dart';

Widget backgroundImage(String imagePath) {
  return Image(
    image: AssetImage(imagePath),
    height: double.infinity,
    width: double.infinity,
    fit: BoxFit.cover,
  );
}

Widget loginTitle(String text) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(40, 20, 0, 20),
    child: Text(
      'Login',
      style: Theme.of(Get.context!).textTheme.headline3!.copyWith(
            color: Palette.palette[100],
            fontWeight: FontWeight.bold,
          ),
    ),
  );


}