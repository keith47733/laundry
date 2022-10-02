import 'package:flutter/material.dart';

import '../styles/palette.dart';

Widget TextInputBox(
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
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 16),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Palette.palette[50],
              ),
        ),
      ),
      TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Palette.palette[100],
          hintText: hint,
        ),
      ),
    ],
  );
}
