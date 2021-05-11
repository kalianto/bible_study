import 'package:flutter/material.dart';
import '../../app_theme.dart';

class Rhema extends StatelessWidget {
  Rhema({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Text('Rhema',
              style:
                  TextStyle(color: AppTheme.darkGrey, fontSize: 18, fontWeight: FontWeight.w600)),
        ]));
  }
}
