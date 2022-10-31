import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';
import '../../providers/my_bible.dart';
import 'bible_app_bar_title.dart';
import 'bible_version_dialog.dart';

class BibleAppBar extends StatelessWidget {
  BibleAppBar({Key key, this.action}) : super(key: key);

  final Function action;

  @override
  Widget build(BuildContext context) {
    MyBibleProvider myBible = Provider.of<MyBibleProvider>(context, listen: true);
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
                IconButton(
                  icon: const Icon(FontAwesomeIcons.arrowLeft),
                  iconSize: 22,
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                  color: AppTheme.darkGrey,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        // padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: BibleAppBarTitle(myBible: myBible, action: action),
                        ),
                      ),
                      BibleVersionDialog(myBible: myBible),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
