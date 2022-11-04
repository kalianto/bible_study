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
      },
    );
  }

  Widget buildAppBarTitle(BuildContext context, data) {
    return InkWell(
      onTap: () {
        action();
      },
      child: Container(
        padding: const EdgeInsets.only(
          top: 5,
          bottom: 5,
          left: 15,
          right: 10,
        ),
        decoration: BoxDecoration(
          color: AppTheme.darkGrey.withOpacity(0.5),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(0.0),
            topRight: Radius.circular(0.0),
          ),
          // border: Border.all(
          //   color: AppTheme.lightGrey,
          // ),
        ),
        child: Text(
          data,
          style: TextStyle(
            fontFamily: AppTheme.fontName,
            fontWeight: FontWeight.w400,
            fontSize: 16,
            letterSpacing: 1.2,
            color: AppTheme.nearlyWhite,
          ),
        ),
      ),
    );
  }
}
