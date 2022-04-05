import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/daily_reading.dart';
import '../../providers/bible_verse_list.dart';
import 'bible_app_bar.dart';
import 'bible_bottom_bar.dart';
import 'bible_content.dart';
import 'bible_selector_drawer.dart';

class BiblePage extends StatefulWidget {
  BiblePage({Key key}) : super(key: key);

  @override
  _BiblePageState createState() => _BiblePageState();
}

class _BiblePageState extends State<BiblePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DailyReading readingItem;

  double swipeLeft = -10.0;
  double swipeRight = 10.0;

  void initState() {
    super.initState();
  }

  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BibleVerseList>(create: (context) => BibleVerseList()),
      ],
      child: SafeArea(
          child: Scaffold(
        key: _scaffoldKey,
        body: GestureDetector(
            onHorizontalDragUpdate: (dragEndDetails) {
              if (dragEndDetails.primaryDelta < swipeLeft) {
                Navigator.of(context).pop();
              } else if (dragEndDetails.primaryDelta > swipeRight) {
                Navigator.of(context).pushNamed('/settings');
              }
            },
            child: Stack(
              children: <Widget>[
                BibleAppBar(action: _openDrawer),
                BibleContent(),
              ],
            )),
        drawer: Drawer(
          child: BibleSelectorDrawer(),
        ),
        bottomNavigationBar: Consumer<BibleVerseList>(builder: (context, bibleVerseList, child) {
          return new BibleBottomBar(bibleVerseList: bibleVerseList);
        }),
      )),
    );
  }
}
