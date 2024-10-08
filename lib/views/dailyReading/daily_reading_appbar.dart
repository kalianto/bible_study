import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';
import '../../models/daily_reading.dart';
import '../../modules/daily_reading.dart' as DailyReadingModule;
import '../../providers/my_bible.dart';
import '../bible/bible_version_dialog.dart';

class DailyReadingAppBar extends StatelessWidget {
  DailyReadingAppBar({Key key, this.item}) : super(key: key);

  final DailyReading item;

  @override
  Widget build(BuildContext context) {
    MyBibleProvider myBible = Provider.of<MyBibleProvider>(context);
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
                    // onPressed: () => Navigator.pop(context, myBible.version),
                    onPressed: () => Navigator.of(context).pop(), // Navigator.popAndPushNamed(context, '/home',
                    // arguments: DateHelper.getDateFromDateId(item.dateId)),
                    tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                    color: AppTheme.darkGrey,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        _buildTitle(item, myBible.version),
                        SizedBox(width: 1),
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
            child: InkWell(
              onTap: () {
                print(item);
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
                  snapshot.data.shortSummary(),
                  //textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    // letterSpacing: 1.2,
                    color: AppTheme.nearlyWhite,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
