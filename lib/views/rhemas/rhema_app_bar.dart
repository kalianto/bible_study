import 'package:flutter/material.dart';

import '../../app_theme.dart';

class RhemaAppBar extends StatelessWidget {
  RhemaAppBar() : super();

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text('Rhema'), backgroundColor: AppTheme.mandarin, actions: <Widget>[
      Container(
        padding: const EdgeInsets.all(0),
      ),
    ]);
  }
}
