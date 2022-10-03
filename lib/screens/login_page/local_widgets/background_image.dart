import 'package:flutter/material.dart';

Widget backgroundImage(String imagePath) {
  return Image(
    image: AssetImage(imagePath),
    height: double.infinity,
    width: double.infinity,
    fit: BoxFit.cover,
  );
}