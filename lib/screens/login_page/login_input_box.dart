import 'package:flutter/material.dart';

import '../../styles/layout.dart';
import '../../styles/app_theme.dart';

Widget loginInputBox(
  final BuildContext context,
  final String title,
  final String hint,
  final TextEditingController controller,
  final TextInputAction inputAction,
) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: lighten(color1, 80)),
      ),
      const SizedBox(height: Layout.SPACING / 2),
      TextField(
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: darken(color1, 80)),
        controller: controller,
        textInputAction: inputAction,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(Layout.SPACING),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Layout.RADIUS),
            ),
            filled: true,
            fillColor: lighten(color1, 80),
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.caption),
      ),
    ],
  );
}
