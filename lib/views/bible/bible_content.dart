import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../app_theme.dart';
import '../../models/bible_view.dart';
import '../../modules/bible_view.dart' as BibleViewModule;
import '../../providers/bible_verse_list.dart';
import '../../providers/my_bible.dart';

class BibleContent extends StatefulWidget {
  @override
  _BibleContentState createState() => _BibleContentState();
}

class _BibleContentState extends State<BibleContent> {
  late AutoScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = AutoScrollController(viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom), axis: Axis.vertical);

    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToIndex(context));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 60),
      child: _buildReadingView(context),
    );
  }

  Widget _buildReadingView(BuildContext context) {
    return Consumer<MyBibleProvider>(
      builder: (context, myBible, child) {
        return FutureBuilder(
          future: BibleViewModule.getBookContent(myBible),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(height: 30),
                    Text('Loading Content'),
                  ],
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            return ListView.builder(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              scrollDirection: Axis.vertical,
              controller: scrollController,
              shrinkWrap: true,
              itemCount: (snapshot.data as List).length,
              itemBuilder: (context, index) {
                final snapshotData = snapshot.data as List;
                if (snapshotData[index].bookVerse == 1) {
                  return _wrapScrollTag(
                    index: index,
                    child: _getRowWithHeading(index, snapshotData[index]),
                  );
                }

                return _wrapScrollTag(
                  index: index,
                  child: _getRowOnly(index, snapshotData[index]),
                );
                // return _getRow(index, snapshot.data);
              },
            );
          },
        );
      },
    );
  }

  Future _scrollToIndex(context) async {
    int index = 0;
    await scrollController.scrollToIndex(index, preferPosition: AutoScrollPosition.begin);
    scrollController.highlight(index);
  }

  Widget _wrapScrollTag({required int index, required Widget child}) => AutoScrollTag(
        key: ValueKey(index),
        controller: scrollController,
        index: index,
        child: child,
        highlightColor: AppTheme.darkGrey.withAlpha((0.5 * 255).toInt()),
      );

  Widget _getRowOnly(int index, BibleView data) {
    return Consumer<BibleVerseListProvider>(
      builder: (context, bibleVerseList, child) {
        return InkWell(
          onTap: () {
            bibleVerseList.addRemoveItem(data);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: bibleVerseList.isSelected(data.id)
                ? BoxDecoration(
                    color: AppTheme.darkGrey.withAlpha((0.5 * 255).toInt()),
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
                  ),
                ),
                Expanded(child: _getBibleText(data)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _getRowWithHeading(int index, BibleView data) => Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              data.bookName + ' ' + data.bookChapter.toString(),
              style: AppTheme.headline5,
            ),
          ),
          _getRowOnly(index, data),
        ],
      );

  Widget _getBibleText(BibleView data) {
    if (data.bibleCode.toLowerCase() == 'web') {
      List<String> matchedText = [];
      String text = data.bookText.replaceAllMapped(
        new RegExp(r'({.*?})'),
        (match) {
          if (match.group(0) != null) {
            matchedText.add(match.group(0)!);
          }
          return '*';
        },
      );
      if (matchedText.length > 0) {
        List<String> splitText = text.split('*');

        if ((splitText.length - 1) == matchedText.length) {
          List<Widget> textSpan = [];
          for (var i = 0; i < splitText.length; i++) {
            textSpan.add(Text(splitText[i], style: AppTheme.body1));
            if (i < matchedText.length) {
              textSpan.add(
                InkWell(
                  onTap: () {
                    _showBibleTextDialog(matchedText[i]);
                  },
                  child: Text(
                    '*',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              );
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
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    Future futureValue = showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );

    return futureValue;
  }
}
