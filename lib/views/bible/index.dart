import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../app_theme.dart';
import '../../models/bible_view.dart';
import '../../models/daily_reading.dart';
import '../../providers/bible_verse_list.dart';
import '../../providers/my_bible.dart';
import '../../services/bible_view.dart';
import 'bible_bottom_bar.dart';
import 'bible_reading_bar.dart';

class BibleViewPage extends StatefulWidget {
  BibleViewPage({Key key, this.readingItem}) : super(key: key);

  final DailyReading readingItem;

  @override
  _BibleViewPageState createState() => _BibleViewPageState();
}

class _BibleViewPageState extends State<BibleViewPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  AutoScrollController scrollController;
  double topBarOpacity = 1.0;

  double swipeLeft = -10.0;
  double swipeRight = 10.0;

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
              } else if (dragEndDetails.primaryDelta > swipeRight) {}
            },
            child: Stack(
              children: <Widget>[
                BibleReadingBar(
                  title: widget.readingItem.shortSummary(),
                ),

                /// Bible Content
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 60),
                  child: Consumer<BibleVerseList>(builder: (context, bibleVerseList, child) {
                    return _buildReadingView(context, bibleVerseList);
                  }),
                ),
              ],
            )),
        bottomNavigationBar: Consumer<BibleVerseList>(builder: (context, bibleVerseList, child) {
          return new BibleBottomBar(bibleVerseList: bibleVerseList);
        }),
      )),
    );
  }

  Future _scrollToIndex(context) async {
    int index = widget.readingItem.sVerse - 1;
    await scrollController.scrollToIndex(index, preferPosition: AutoScrollPosition.begin);
    scrollController.highlight(index);
  }

  Future<List<BibleView>> getBookContent(int bibleVersion) async {
    var dbClient = BibleViewProvider();
    List<BibleView> bibleViewList = await dbClient.getBibleView(widget.readingItem, bibleVersion);
    return bibleViewList;
  }

  Widget _wrapScrollTag({int index, Widget child}) => AutoScrollTag(
        key: ValueKey(index),
        controller: scrollController,
        index: index,
        child: child,
        highlightColor: AppTheme.darkGrey.withOpacity(0.5),
      );

  Widget _getBibleText(BibleView data) {
    if (data.bibleCode.toLowerCase() == 'web') {
      List<String> matchedText = [];
      String text = data.bookText.replaceAllMapped(new RegExp(r'({.*?})'), (match) {
        matchedText.add(match.group(0));
        return '*';
      });
      if (matchedText.length > 0) {
        List<String> splitText = text.split('*');

        if ((splitText.length - 1) == matchedText.length) {
          List<Widget> textSpan = [];
          for (var i = 0; i < splitText.length; i++) {
            textSpan.add(Text(splitText[i], style: AppTheme.body1));
            if (i < matchedText.length) {
              textSpan.add(InkWell(
                  onTap: () {
                    _showBibleTextDialog(matchedText[i]);
                  },
                  child: Text('*',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ))));
            }
          }
          return Wrap(direction: Axis.horizontal, children: textSpan);
          // return Text(data.bookText, style: AppTheme.body1);
        } else {
          return Text(data.bookText, style: AppTheme.body1);
        }
      } else {
        return Text(data.bookText, style: AppTheme.body1);
      }
    } else {
      return Text(data.bookText, style: AppTheme.body1);
    }
  }

  Future<void> _showBibleTextDialog(String refText) async {
    String text = refText.replaceAll(new RegExp(r'{|}'), '');
    AlertDialog dialog = AlertDialog(
      title: Text('Reference'),
      content: SingleChildScrollView(
          child: ListBody(
        children: <Widget>[Text(text, style: AppTheme.body1)],
      )),
      actions: <Widget>[
        TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );

    Future futureValue = showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });

    return futureValue;
  }

  Widget _getRowOnly(int index, BibleView data, BibleVerseList bibleVerseList) => InkWell(
        onTap: () {
          bibleVerseList.addRemoveItem(data);
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: bibleVerseList.isSelected(data.id)
              ? BoxDecoration(
                  color: AppTheme.darkGrey.withOpacity(0.5),
                )
              : BoxDecoration(),
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
              Expanded(child: _getBibleText(data)),
            ],
          ),
        ),
      );

  Widget _getRowWithHeading(int index, BibleView data, BibleVerseList bibleVerseList) =>
      Column(children: <Widget>[
        Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child:
                Text(data.bookName + ' ' + data.bookChapter.toString(), style: AppTheme.headline5)),
        _getRowOnly(index, data, bibleVerseList),
      ]);

  Widget _buildReadingView(BuildContext context, BibleVerseList bibleVerseList) {
    return Consumer<MyBible>(builder: (context, myBible, child) {
      return FutureBuilder(
        future: getBookContent(myBible.version),
        builder: (context, snapshot) {
          if (ConnectionState.active != null && !snapshot.hasData) {
            return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(height: 30),
                  Text('Loading Content'),
                ]));
          }

          if (ConnectionState.done != null && snapshot.hasError) {
            return Center(child: Text(snapshot.error));
          }

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
                    child: _getRowWithHeading(index, snapshot.data[index], bibleVerseList),
                  );
                }

                return _wrapScrollTag(
                  index: index,
                  child: _getRowOnly(index, snapshot.data[index], bibleVerseList),
                );
                // return _getRow(index, snapshot.data);
              });
        },
      );
    });
  }
}
