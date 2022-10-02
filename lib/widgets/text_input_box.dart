import 'package:flutter/material.dart';

import '../styles/palette.dart';
import '../styles/style.dart';

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
        padding: const EdgeInsets.fromLTRB(
			Style.appSpacing,
			Style.appSpacing/2,
			Style.appSpacing,
			Style.appSpacing,),
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
            borderRadius: BorderRadius.circular(Style.appRadius),
          ),
          filled: true,
          fillColor: Palette.palette[100],
          hintText: hint,
        ),
      ),
    ],
  );
}
