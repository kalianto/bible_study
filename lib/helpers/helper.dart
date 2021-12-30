import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

bool isValidEmail(String emailAddress) {
  bool emailValid = new RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
      .hasMatch(emailAddress);
  return emailValid;
}

void showAlertDialog(String title, String text, BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: <Widget>[
            TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        );
      });
}
