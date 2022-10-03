import 'package:flutter/material.dart';

import '../../../styles/style.dart';

Widget homepageBanner() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(
      0,
      Style.appSpacing,
      0,
      0,
    ),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Style.appRadius),
      ),
      elevation: Style.cardElevation,
      // child: Container(
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(Style.appRadius),
      //   ),
      child: ClipRRect(
				borderRadius: BorderRadius.circular(Style.appRadius),
				child: const Image(
					image: AssetImage('./assets/images/homepage_banner.jpg'),
					width: double.infinity,
					fit: BoxFit.cover,
				),
			),
    ),
  );
}
