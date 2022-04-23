import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';
import '../../models/daily_reading.dart';
import '../../modules/daily_reading.dart' as DailyReadingModule;
import '../../providers/my_bible.dart';
import 'bible_version_dialog.dart';

class BibleReadingBar extends StatelessWidget {
  BibleReadingBar({Key key, this.item}) : super(key: key);

  final DailyReading item;

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
                Consumer<MyBibleProvider>(builder: (context, myBible, child) {
                  return IconButton(
                    icon: const Icon(FontAwesomeIcons.arrowLeft),
                    iconSize: 22,
                    onPressed: () => Navigator.pop(context, myBible.version),
                    tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                    color: AppTheme.darkGrey,
                  );
                }),
                Consumer<MyBibleProvider>(builder: (context, myBible, child) {
                  return Expanded(
                      child:
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                    _buildTitle(item, myBible.version),
                    Consumer<MyBibleProvider>(builder: (context, myBible, child) {
                      return BibleVersionDialog(myBible: myBible);
                    }),
                  ]));
                }),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTitle(DailyReading item, int bibleVersion) {
    return FutureBuilder(
      future: DailyReadingModule.getDailyReadingItemById(item.id, bibleVersion),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (ConnectionState.active != null && !snapshot.hasData) {
          return Text('loading');
        }
        return Flexible(
          // padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(snapshot.data.shortSummary(),
                //textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  letterSpacing: 1.2,
                  color: AppTheme.darkGrey,
                )),
          ),
        );
      },
    );
  }
}
