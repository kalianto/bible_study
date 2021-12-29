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
          child: BottomBarNavigation(context),
        ));
  }

  Widget BottomBarNavigation(BuildContext context) {
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
              ),
              Text('READING',
                  style: TextStyle(
                    fontSize: 10,
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
              ),
              Text('RHEMA',
                  style: TextStyle(
                    fontSize: 10,
                  )),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          Column(
            children: <Widget>[
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.cross, size: 22, color: AppTheme.redText),
              ),
              Text('PLAN',
                  style: TextStyle(
                    fontSize: 10,
                  )),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          Column(
            children: <Widget>[
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.users, size: 22, color: AppTheme.yellowText),
              ),
              Text('COOL',
                  style: TextStyle(
                    fontSize: 10,
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
                  Navigator.of(context).popAndPushNamed('/bible');
                },
              ),
              Text('BIBLE',
                  style: TextStyle(
                    fontSize: 10,
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
