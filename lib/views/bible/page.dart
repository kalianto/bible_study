import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/daily_reading.dart';
import '../../providers/bible_verse_list.dart';
import '../../providers/my_bible.dart';
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

  void goToPreviousChaper() {
    MyBibleProvider myBible = Provider.of<MyBibleProvider>(context, listen: false);
    myBible.goToPreviousVerse();
  }

  void goToNextChaper() {
    MyBibleProvider myBible = Provider.of<MyBibleProvider>(context, listen: false);
    myBible.goToNextVerse();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BibleVerseListProvider>(create: (context) => BibleVerseListProvider()),
      ],
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          body: GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity > 0) {
                goToPreviousChaper();
                // Navigator.of(context).pop();
              } else {
                goToNextChaper();
              }
            },
            child: Stack(
              children: <Widget>[
                BibleAppBar(action: _openDrawer),
                BibleContent(),
              ],
            ),
          ),
          drawer: Drawer(
            child: BibleSelectorDrawer(),
          ),
          bottomNavigationBar: Consumer<BibleVerseListProvider>(
            builder: (context, bibleVerseList, child) {
              return new BibleBottomBar(bibleVerseList: bibleVerseList, date: DateTime.now());
            },
          ),
        ),
      ),
    );
  }
}
