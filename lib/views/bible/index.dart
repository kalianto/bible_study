import 'package:bible_study/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  AutoScrollController scrollController;
  double topBarOpacity = 1.0;

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
      body: Stack(children: <Widget>[
        bibleViewAppBar(),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 60),
          child: _buildReadingView(context),
        ),
      ]),
    ));
  }

  Widget bibleViewAppBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.darkGrey.withOpacity(0.4),
      ),
      height: 60,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16 - 8.0 * topBarOpacity,
                bottom: 12 - 8.0 * topBarOpacity),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 38,
                  width: 38,
                  child: IconButton(
                    icon: const Icon(FontAwesomeIcons.arrowLeft),
                    onPressed: () => Navigator.of(context).pop(),
                    tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                    color: AppTheme.darkGrey,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.readingItem.shortSummary(),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontWeight: FontWeight.w700,
                        fontSize: 22 + 6 - 6 * topBarOpacity,
                        letterSpacing: 1.2,
                        color: AppTheme.darkGrey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
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
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: const EdgeInsets.only(left: 0, right: 6),
                child: Text(
                  data[index].bookVerse.toString(),
                  style: AppTheme.body2,
                )),
            Expanded(child: Text(data[index].bookText, style: AppTheme.body1)),
          ],
        ),
      ));

  Widget _getRowOnly(int index, BibleView data) => Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: const EdgeInsets.only(left: 0, right: 6),
                child: Text(
                  data.bookVerse.toString(),
                  style: AppTheme.body2,
                )),
            Expanded(child: Text(data.bookText, style: AppTheme.body1)),
          ],
        ),
      );

  Widget _getRowWithHeading(int index, BibleView data) => Column(children: <Widget>[
        SizedBox(height: 10),
        Container(
            // padding: const EdgeInsets.only(top: 5, bottom: 5),
            child:
                Text(data.bookName + ' ' + data.bookChapter.toString(), style: AppTheme.headline5)),
        SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(8),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.only(left: 0, right: 6),
                    child: Text(
                      data.bookVerse.toString(),
                      style: AppTheme.body2,
                    )),
                Expanded(child: Text(data.bookText, style: AppTheme.body1)),
              ]),
        )
      ]);

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

        /// TODO: show Book Name: Chapter
        /// TODO: show multiple chapter??
        return ListView.builder(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            scrollDirection: Axis.vertical,
            controller: scrollController,
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              if (snapshot.data[index].bookVerse == 1) {
                return _wrapScrollTag(
                  index: index,
                  child: _getRowWithHeading(index, snapshot.data[index]),
                );
              }

              return _wrapScrollTag(
                index: index,
                child: _getRowOnly(index, snapshot.data[index]),
              );
              // return _getRow(index, snapshot.data);
            });
      },
    );
  }
}
