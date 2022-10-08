import 'package:flutter/material.dart';

import '../../../styles/layout.dart';

Widget homepageBanner() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(
      0,
      Layout.appSpacing / 2,
      0,
      Layout.appSpacing / 2,
    ),
    child: Card(
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
