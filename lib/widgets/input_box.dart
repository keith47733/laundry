import 'package:flutter/material.dart';

import '../styles/layout.dart';

Widget inputBox(
  final BuildContext context,
  final String title,
  final String hint,
  final TextEditingController controller,
) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(
          0,
          0,
          0,
          Layout.appSpacing / 2,
        ),
        child: Text(
          textScaleFactor: 0.75,
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(
          0,
          0,
          0,
          Layout.appSpacing,
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.all(Layout.appSpacing / 1.25),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Layout.appRadius),
            ),
            filled: true,
            // fillColor: Palette.palette[50],
            hintText: hint,
          ),
        ),
      ),
    ],
  );
}
