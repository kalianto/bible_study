import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../models/bible_view.dart';
import '../../models/daily_reading.dart';
import '../../providers/bible_view.dart';

class BibleViewPage extends StatefulWidget {
  BibleViewPage({Key, key, this.readingItem}) : super(key: Key);

  final DailyReading readingItem;

  // final BibleView item;

  @override
  _BibleViewPageState createState() => _BibleViewPageState();
}

class _BibleViewPageState extends State<BibleViewPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      body: _buildReadingView(context),
    ));
  }

  Future<List<BibleView>> getBookContent() async {
    var dbClient = BibleViewProvider();
    List<BibleView> bibleViewList = await dbClient.getBibleView(widget.readingItem, 't_asv');
    return bibleViewList;
  }

  Widget _buildReadingView(BuildContext context) {
    return FutureBuilder(
      future: getBookContent(),
      builder: (context, snapshot) {
        if (ConnectionState.active != null && !snapshot.hasData) {
          return Center(
              child: Column(children: <Widget>[
            SizedBox(height: 20),
            CircularProgressIndicator(),
            SizedBox(height: 40),
            Text('Loading Daily Reading ...'),
          ]));
        }

        if (ConnectionState.done != null && snapshot.hasError) {
          return Center(child: Text(snapshot.error));
        }

        return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(snapshot.data[index].bookVerse.toString())),
                    Expanded(child: Text(snapshot.data[index].bookText)),
                  ],
                ),
              );
            });
      },
    );
  }
}
