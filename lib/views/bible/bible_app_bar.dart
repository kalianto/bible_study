import 'package:cool/views/bible/bible_app_bar_title.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';
import '../../providers/my_bible.dart';
import 'bible_version_dialog.dart';

class BibleAppBar extends StatelessWidget {
  BibleAppBar({Key key, this.action}) : super(key: key);

  final Function action;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.darkGrey.withOpacity(0.4),
      ),
      height: 60,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 6,
              bottom: 6,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Consumer<MyBible>(builder: (context, myBible, child) {
                  return IconButton(
                    icon: const Icon(FontAwesomeIcons.arrowLeft),
                    iconSize: 22,
                    onPressed: () => Navigator.pop(context, myBible.version),
                    tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                    color: AppTheme.darkGrey,
                  );
                }),
                Consumer<MyBible>(builder: (context, myBible, child) {
                  return Expanded(
                      child:
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                    Flexible(
                      // padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: BibleAppBarTitle(myBible: myBible, action: action),
                      ),
                    ),
                    BibleVersionDialog(myBible: myBible),
                  ]));
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
