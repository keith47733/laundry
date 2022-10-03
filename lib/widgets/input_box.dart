import 'package:flutter/material.dart';

import '../../../styles/palette.dart';
import '../../../styles/style.dart';

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
          Style.appSpacing / 2,
        ),
        child: Text(
					textScaleFactor: 0.75,
          title,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Palette.palette[700],
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
						isDense: true,
						contentPadding: const EdgeInsets.all(Style.appSpacing / 1.25),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Style.appRadius),
            ),
            filled: true,
            fillColor: Palette.palette[50],
            hintText: hint,
          ),
        ),
      ),
    ],
  );
}
