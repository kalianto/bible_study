import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import 'package:flutter/services.dart';

import '../../app_theme.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  HomeBottomNavigationBar({Key key}) : super(key: key);

  // final BibleVerseList bibleVerseList;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        // color: AppTheme.nearlyBlack.withOpacity(0.8),
        child: IconTheme(
          data: IconThemeData(color: AppTheme.darkGreen),
          child: bottomBarNavigation(context),
        ));
  }

  Widget bottomBarNavigation(BuildContext context) {
    double iconFontSize = 10.0;

    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.prayingHands,
                    size: 22, color: AppTheme.greenText),
                onPressed: () {
                  Navigator.of(context).popAndPushNamed('/home');
                },
              ),
              Text('GEMA',
                  style: TextStyle(
                    fontSize: iconFontSize,
                  )),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          Column(
            children: <Widget>[
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.flagCheckered,
                    size: 22, color: AppTheme.mandarin),
                onPressed: () {
                  Navigator.of(context).pushNamed('/rhema');
                },
              ),
              Text('RHEMA',
                  style: TextStyle(
                    fontSize: iconFontSize,
                  )),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          Column(
            children: <Widget>[
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.newspaper, size: 22, color: AppTheme.redText),
                onPressed: () {
                  Navigator.of(context).pushNamed('/news');
                },
              ),
              Text('NEWS',
                  style: TextStyle(
                    fontSize: iconFontSize,
                  )),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          Column(
            children: <Widget>[
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.solidStickyNote,
                    size: 22, color: AppTheme.yellowText),
                onPressed: () {
                  Navigator.of(context).pushNamed('/notes');
                },
              ),
              Text('NOTES',
                  style: TextStyle(
                    fontSize: iconFontSize,
                  )),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          Column(
            children: <Widget>[
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.bible, size: 22, color: AppTheme.blueText),
                onPressed: () {
                  Navigator.of(context).pushNamed('/bible');
                },
              ),
              Text('BIBLE',
                  style: TextStyle(
                    fontSize: iconFontSize,
                  )),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),

          // IconButton(
          //   icon: const FaIcon(FontAwesomeIcons.flagCheckered, size: 22, color: AppTheme.mandarin),
          //   tooltip: 'Rhema',
          // ),
          // IconButton(
          //   icon: const FaIcon(FontAwesomeIcons.cross, size: 22, color: AppTheme.redText),
          // ),
          // IconButton(
          //   icon: const FaIcon(FontAwesomeIcons.users, size: 22, color: AppTheme.yellowText),
          // ),
          // IconButton(
          //   icon: const FaIcon(FontAwesomeIcons.bible, size: 22, color: AppTheme.blueText),
          // )
        ],
      ),
    );
  }
}
