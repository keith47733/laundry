import 'package:flutter/material.dart';

Widget backgroundImage(String imagePath) {
  return Hero(
    tag: 'laundry',
    child: Image.asset(
      imagePath,
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.cover,
    ),
  );
}
