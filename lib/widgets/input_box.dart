import 'package:flutter/material.dart';
import 'package:laundry/theme/app_theme.dart';

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
  		Text(
  			title,
  			style: Theme.of(context).textTheme.bodyMedium,
  		),
  		Padding(
  			padding: const EdgeInsets.fromLTRB(
  				0,
  				Layout.appSpacing / 2,
  				0,
  				Layout.appSpacing / 2,
  			),
  			child: TextField(
  				style: Theme.of(context).textTheme.bodySmall?.copyWith(color: darken(color1,80)),
  				controller: controller,
  				decoration: InputDecoration(
  						isDense: true,
  						contentPadding: const EdgeInsets.all(Layout.appSpacing / 1.25),
  						border: OutlineInputBorder(
  							borderRadius: BorderRadius.circular(Layout.appRadius),
  						),
  						filled: true,
  						fillColor: lighten(color1, 80),
  						hintText: hint,
  						hintStyle: Theme.of(context).textTheme.caption),
  			),
  		),
  	],
  );
}
