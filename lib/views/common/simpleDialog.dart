import 'package:flutter/material.dart';

void showSimpleDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text(title),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(message),
          ),
        ],
      );
    },
  );
}
