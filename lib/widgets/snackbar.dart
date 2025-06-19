import 'package:flutter/material.dart';

void successSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        showCloseIcon: true,
        behavior: SnackBarBehavior.floating),
  );
}

void errorSnackBar(BuildContext context, String error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(error),
        backgroundColor: Colors.red,
        showCloseIcon: true,
        behavior: SnackBarBehavior.floating),
  );
}
