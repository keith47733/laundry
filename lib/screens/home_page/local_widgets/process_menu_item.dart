import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../styles/palette.dart';
import '../../../styles/style.dart';

Widget processMenuItem(String title, Function onTap) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        0,
        0,
        0,
        Style.appSpacing / 2,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(Style.appRadius),
        color: Palette.palette[200],
        child: InkWell(
          onTap: () => onTap(),
          borderRadius: BorderRadius.circular(Style.appRadius),
          child: Padding(
            padding: const EdgeInsets.all(Style.appSpacing / 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  textScaleFactor: 0.8,
                  title,
                  style: Theme.of(Get.context!).textTheme.headline6,
                ),
                const Icon(
                  Icons.navigate_next,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
