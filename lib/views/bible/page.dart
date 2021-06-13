import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/daily_reading.dart';
import '../../services/bible_view.dart';
import '../../models/bible_view.dart';
import '../../providers/bible_verse_list.dart';
import '../../providers/my_bible.dart';
import 'bible_bottom_bar.dart';
import 'bible_app_bar.dart';
import 'bible_content.dart';

class BiblePage extends StatefulWidget {
  BiblePage({Key key}) : super(key: key);

  @override
  _BiblePageState createState() => _BiblePageState();
}

class _BiblePageState extends State<BiblePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DailyReading readingItem;
  List<BibleView> bibleContent = [];

  void initState() {
    super.initState();
    _loadBibleContent();
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
        body: Stack(
          children: <Widget>[
            BibleAppBar(title: 'Genesis 1'),
            BibleContent(),
          ],
        ),
        bottomNavigationBar: Consumer<BibleVerseList>(builder: (context, bibleVerseList, child) {
          return new BibleBottomBar(bibleVerseList: bibleVerseList);
        }),
      )),
    );
  }

  Future<void> _loadBibleContent() async {
    MyBible myBible = Provider.of<MyBible>(context, listen: false);
    var dbClient = BibleViewProvider();
    bibleContent = await dbClient.getBibleContent(
        bibleVersionId: myBible.version, verseStart: myBible.lastBibleVerse);
  }
}
