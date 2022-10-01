import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppFormat {
  static String date(DateTime dateTime) {
    return DateFormat('EEE MMM d, yyyy').format(dateTime);
  }

  static String time(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  static String currency(double price) {
    return NumberFormat.currency(
      decimalDigits: 2,
      symbol: '\$',
      locale: 'en_US',
    ).format(price);
  }
}
