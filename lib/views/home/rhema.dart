import 'package:flutter/material.dart';

import '../../app_theme.dart';

class Rhema extends StatelessWidget {
  Rhema({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildRhemaHeader(context),
              SizedBox(height: 20),
              buildRhemaContent(context),
            ]));
  }

  Widget buildRhemaHeader(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          Text('Rhema',
              style:
                  TextStyle(color: AppTheme.darkGrey, fontSize: 20, fontWeight: FontWeight.w500)),
          Text('View All',
              style:
                  TextStyle(color: AppTheme.blueText, fontSize: 14, fontWeight: FontWeight.w500)),
        ]);
  }

  Widget buildRhemaContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: AppTheme.boxShadowless,
      child: Text('Rhema'),
    );
  }
}
