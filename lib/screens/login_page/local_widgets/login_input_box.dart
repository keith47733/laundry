import 'package:flutter/material.dart';

import '../../../theme/layout.dart';

Widget loginInputBox(
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
          title,
          style: Theme.of(context).textTheme.headline6!.copyWith(
              // color: Palette.palette[50],
              ),
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Layout.appRadius),
            ),
            contentPadding: const EdgeInsets.all(Layout.appSpacing / 1.25),
            filled: true,
            // fillColor: Palette.palette[50],
            hintText: hint,
          ),
        ),
      ),
    ],
  );
}
