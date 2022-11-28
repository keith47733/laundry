import 'package:flutter/material.dart';
import 'package:laundry/styles/app_theme.dart';

import '../../styles/layout.dart';

Widget inputBox(
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
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      const SizedBox(height: Layout.SPACING / 2),
      TextField(
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: darken(color1, 80),
            ),
        controller: controller,
        textInputAction: inputAction,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.all(Layout.SPACING / 1.25),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Layout.RADIUS),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.caption,
        ),
      ),
    ],
  );
}
