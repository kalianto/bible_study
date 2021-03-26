import 'package:bible_study/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

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

  var scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = AutoScrollController(
        viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToIndex(context));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      body: _buildReadingView(context),
    ));
  }

  Future _scrollToIndex(context) async {
    int index = widget.readingItem.sVerse - 1;
    await scrollController.scrollToIndex(index, preferPosition: AutoScrollPosition.begin);
    scrollController.highlight(index);
  }

  Future<List<BibleView>> getBookContent() async {
    var dbClient = BibleViewProvider();
    List<BibleView> bibleViewList = await dbClient.getBibleView(widget.readingItem, 't_asv');
    return bibleViewList;
  }

  Widget _wrapScrollTag({int index, Widget child}) => AutoScrollTag(
        key: ValueKey(index),
        controller: scrollController,
        index: index,
        child: child,
        highlightColor: AppTheme.darkGrey.withOpacity(0.5),
      );

  Widget _getRow(int index, data) => _wrapScrollTag(
      index: index,
      child: Container(
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(data[index].bookVerse.toString())),
            Expanded(child: Text(data[index].bookText)),
          ],
        ),
      ));

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
            controller: scrollController,
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return _getRow(index, snapshot.data);
            });
      },
    );
  }
}
