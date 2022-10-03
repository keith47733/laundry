import 'package:flutter/material.dart';

import '../../../theme/layout.dart';

Widget homepageBanner() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(
      0,
      Layout.appSpacing,
      0,
      0,
    ),
    child: Card(
      elevation: Layout.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Layout.appRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Layout.appRadius),
        child: const Image(
          image: AssetImage('./assets/images/homepage_banner.jpg'),
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
