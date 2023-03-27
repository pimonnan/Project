import 'package:flutter/material.dart';

class Utils {
  bool isEmailFormat(String input) =>
      RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
          .hasMatch(input);

  showSnackBar(
      BuildContext context, String message, int millisecond, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: color.withOpacity(1.0),
        duration: Duration(milliseconds: millisecond),
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
