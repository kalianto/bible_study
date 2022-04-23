import 'package:flutter/material.dart';

import '../../app_theme.dart';
import '../../modules/my_bible.dart' as MyBibleModule;
import '../../providers/my_bible.dart';

class BibleAppBarTitle extends StatelessWidget {
  BibleAppBarTitle({Key key, this.myBible, this.action}) : super(key: key);

  final MyBibleProvider myBible;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MyBibleModule.getBookChapter(myBible),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (ConnectionState.active != null && !snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return buildAppBarTitle(context, snapshot.data);
        });
  }

  Widget buildAppBarTitle(BuildContext context, data) {
    return InkWell(
      onTap: () {
        action();
      },
      child: Chip(
          backgroundColor: AppTheme.blueText.withOpacity(0.8),
          label: Text(data,
              style: TextStyle(
                fontFamily: AppTheme.fontName,
                fontWeight: FontWeight.w400,
                fontSize: 18,
                letterSpacing: 1.2,
                color: AppTheme.nearlyWhite,
              ))),
    );
  }
}
