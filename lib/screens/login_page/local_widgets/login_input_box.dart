import 'package:flutter/material.dart';

import '../../../styles/palette.dart';
import '../../../styles/style.dart';

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
          Style.appSpacing / 2,
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Palette.palette[50],
              ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(
          0,
          0,
          0,
          Style.appSpacing,
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Style.appRadius),
            ),
            contentPadding: const EdgeInsets.all(Style.appSpacing / 1.25),
            filled: true,
            fillColor: Palette.palette[50],
            hintText: hint,
          ),
        ),
      ),
    ],
  );
}
