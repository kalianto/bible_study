import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../app_theme.dart';
import '../../models/bible_view.dart';
import '../../models/daily_reading.dart';
import '../../models/daily_reading_arguments.dart';
import '../../modules/bible_view.dart' as BibleViewModule;
import '../../providers/bible_verse_list.dart';
import '../../providers/my_bible.dart';

/// change this two object to daily reading bar
import '../bible/bible_bottom_bar.dart';
import '../bible/bible_reading_bar.dart';

class DailyReadingPage extends StatefulWidget {
  DailyReadingPage({Key key, this.arguments}) : super(key: key);

  final DailyReadingArguments arguments;

  @override
  _DailyReadingPageState createState() => _DailyReadingPageState();
}

class _DailyReadingPageState extends State<DailyReadingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  AutoScrollController scrollController;
  double swipeLeft = -10.0;
  double swipeRight = 10.0;
  DailyReading readingItem;
  int dailyReadingIndex;
  DateTime dailyReadingDate;

  @override
  void initState() {
    super.initState();
    scrollController = AutoScrollController(
        viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);

    /// WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToIndex(context));
    setReadingItem(widget.arguments.item);
    setDailyReadingIndex(widget.arguments.index);
    setDailyReadingDate(widget.arguments.date);
  }

  void setDailyReadingIndex(int index) {
    setState(() {
      dailyReadingIndex = index;
    });
  }

  void setReadingItem(DailyReading item) {
    setState(() {
      readingItem = item;
    });
  }

  void setDailyReadingDate(DateTime date) {
    setState(() {
      dailyReadingDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BibleVerseListProvider>(
            create: (context) => BibleVerseListProvider()),
      ],
      child: SafeArea(
          child: Scaffold(
        key: _scaffoldKey,
        body: GestureDetector(
            onHorizontalDragUpdate: (dragEndDetails) {
              if (dragEndDetails.primaryDelta < swipeLeft) {
                int nextIndex = dailyReadingIndex + 1;
                if (nextIndex >= widget.arguments.itemList.length) {
                  Navigator.of(context).popAndPushNamed('/home', arguments: dailyReadingDate);
                } else {
                  DailyReadingArguments arguments = new DailyReadingArguments(
                      index: nextIndex,
                      item: widget.arguments.itemList[nextIndex],
                      date: widget.arguments.date,
                      itemList: widget.arguments.itemList);
                  Navigator.of(context).popAndPushNamed('/daily-reading', arguments: arguments);
                }
              } else if (dragEndDetails.primaryDelta > swipeRight) {
                int prevIndex = dailyReadingIndex - 1;
                if (prevIndex < 0) {
                  Navigator.of(context).popAndPushNamed('/home', arguments: dailyReadingDate);
                } else {
                  DailyReadingArguments arguments = new DailyReadingArguments(
                      index: prevIndex,
                      item: widget.arguments.itemList[prevIndex],
                      date: widget.arguments.date,
                      itemList: widget.arguments.itemList);
                  Navigator.of(context).popAndPushNamed('/daily-reading', arguments: arguments);
                }
              }
            },
            child: Stack(
              children: <Widget>[
                BibleReadingBar(item: readingItem),

                /// Bible Content
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 60),
                  child:
                      Consumer<BibleVerseListProvider>(builder: (context, bibleVerseList, child) {
                    return _buildReadingView(context, bibleVerseList);
                  }),
                ),
              ],
            )),
        bottomNavigationBar:
            Consumer<BibleVerseListProvider>(builder: (context, bibleVerseList, child) {
          return new BibleBottomBar(bibleVerseList: bibleVerseList, date: readingItem.fullDate);
        }),
      )),
    );
  }

  Widget _buildReadingView(BuildContext context, BibleVerseListProvider bibleVerseList) {
    return Consumer<MyBibleProvider>(builder: (context, myBible, child) {
      return FutureBuilder(
        future: BibleViewModule.getDailyReadingContent(readingItem, myBible.version),
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

  Widget _getRowOnly(int index, BibleView data, BibleVerseListProvider bibleVerseList) => InkWell(
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

  Widget _getRowWithHeading(int index, BibleView data, BibleVerseListProvider bibleVerseList) =>
      Column(children: <Widget>[
        Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child:
                Text(data.bookName + ' ' + data.bookChapter.toString(), style: AppTheme.headline5)),
        _getRowOnly(index, data, bibleVerseList),
      ]);

  Widget _wrapScrollTag({int index, Widget child}) => AutoScrollTag(
        key: ValueKey(index),
        controller: scrollController,
        index: index,
        child: child,
        highlightColor: AppTheme.darkGrey.withOpacity(0.5),
      );

  /*Future _scrollToIndex(context) async {
    int index = widget.readingItem.sVerse - 1;
    await scrollController.scrollToIndex(index, preferPosition: AutoScrollPosition.begin);
    scrollController.highlight(index);
  }*/
}
