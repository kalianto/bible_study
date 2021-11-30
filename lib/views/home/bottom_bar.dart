import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';

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
        child: BottomBarNavigation(),
      )
    );
  }

  Widget BottomBarNavigation() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.prayingHands, size: 22, color: AppTheme.greenText),
            tooltip: 'Daily Reading',
          ),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.flagCheckered, size: 22, color: AppTheme.mandarin),
            tooltip: 'Rhema',
          ),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.cross, size: 22, color: AppTheme.redText),
          ),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.users, size: 22, color: AppTheme.yellowText),
          ),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.bible, size: 22, color: AppTheme.blueText),
          )
        ],
      ),
    );
  }
}
