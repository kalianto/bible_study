import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_theme.dart';
import '../../app_config.dart';
import '../../models/bible_view.dart';
import '../../models/bible_version.dart';
import '../../models/daily_reading.dart';
import '../../providers/bible_view.dart';
import 'bible_app_bar.dart';

class BibleViewPage extends StatefulWidget {
  BibleViewPage({Key key, this.readingItem}) : super(key: key);

  final DailyReading readingItem;

  // final BibleView item;

  @override
  _BibleViewPageState createState() => _BibleViewPageState();
}

class _BibleViewPageState extends State<BibleViewPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  AutoScrollController scrollController;
  double topBarOpacity = 1.0;

  List<BibleVersion> bibleVersionList = List();
  int selectedBibleVersionIndex; // = 8;

  List<BibleView> selectedList = List();

  @override
  void initState() {
    super.initState();
    scrollController = AutoScrollController(
        viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);
    _loadBibleVersion();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToIndex(context));
  }

  void _loadBibleVersion() async {
    final prefs = await SharedPreferences.getInstance();
    final key = AppConfig.bibleVersion;
    int version = prefs.getInt(key) ?? 1;
    setSelectedIndex(version);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      body: Stack(children: <Widget>[
        //bibleViewAppBar(),
        new BibleAppBar(
          dailyReadingItem: widget.readingItem,
          selectedIndex: selectedBibleVersionIndex,
          setSelectedIndex: setSelectedIndex,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 60),
          child: _buildReadingView(context),
        ),
      ]),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    ));
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    if (selectedList.isEmpty) {
      return Padding(padding: const EdgeInsets.all(0));
    }
    return Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          padding: const EdgeInsets.only(left: 14),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text('${selectedList.length} verse' +
                      (selectedList.length > 1 ? 's selected' : ' selected')),
                ),
                Container(
                  child: PopupMenuButton(
                    icon: const FaIcon(FontAwesomeIcons.ellipsisV, size: 16),
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'clear',
                        child: Text('Clear'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'copy',
                        child: Text('Copy'),
                      ),
                      const PopupMenuItem<String>(value: 'share', child: Text('Share'))
                    ],
                    onSelected: (value) {
                      String shareMessage = '';
                      if (value != 'clear') {
                        selectedList.sort((a, b) => a.id.compareTo(b.id));
                        shareMessage = _generateShareMessage(selectedList);
                      }

                      if (value == 'share') {
                        Share.share(shareMessage);
                      }

                      if (value == 'copy') {
                        Clipboard.setData(new ClipboardData(text: shareMessage));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('Copied to clipboard'),
                          duration: const Duration(seconds: 2),
                        ));
                      }

                      setState(() {
                        selectedList.clear();
                      });
                    },
                  ),
                ),
              ]),
          color: AppTheme.darkGreen.withOpacity(0.8),
        ));
  }

  /// Generate share/copy message function
  ///
  /// case 1: same book, same chapter, verses copied in sequence
  /// case 2: same book, same chapter, verses not in sequence
  /// case 3: same book, different chapter, verses copied in sequence
  /// case 4: same book, different chapter, verses copied not in sequence
  /// case 3: different book, verses copied in sequence
  /// case 4: different book, verses copied not in sequence
  String _generateShareMessage(List<BibleView> selectedList) {
    if (selectedList.length == 0) {
      return '';
    }

    /// Function to craft the message
    String buildMessage(List<BibleView> selectedList) {
      String message =
          selectedList[0].bookName + ' ' + selectedList[0].bookChapter.toString() + ':';
      // chapter list for checking
      List<int> chapterList = [];
      chapterList.add(selectedList[0].bookChapter);

      // verse list for messge concatenation
      List<dynamic> verseList = [];
      verseList.add(selectedList[0].bookVerse);
      verseList.add('-');

      // text list for bible content
      List<String> textList = [];
      textList.add(selectedList[0].bookText);

      for (var i = 1; i < selectedList.length; i++) {
        // different chapter
        if (selectedList[i].bookChapter != chapterList.last) {
          chapterList.add(selectedList[i].bookChapter);
          if (verseList.last == '-') {
            verseList.removeLast();
          }
          verseList.add(' | ');
          // verseList.add(selectedList[i].bookName + ' ');
          verseList.add(selectedList[i].bookChapter.toString());
          verseList.add(':');
        }
        // add verse and text
        if ((selectedList[i].bookVerse - selectedList[i - 1].bookVerse) == 1) {
          if (verseList.last is int) {
            if (verseList[verseList.length - 2] == '-') {
              verseList.removeLast();
            } else if (verseList[verseList.length - 2] == ',' ||
                verseList[verseList.length - 2] == ':') {
              verseList.add('-');
            }
          }
          verseList.add(selectedList[i].bookVerse);
          textList.add(selectedList[i].bookText);
        } else {
          if (verseList.last == '-') {
            verseList.removeLast();
          }
          if (verseList.last != ':') {
            verseList.add(',');
          }
          verseList.add(selectedList[i].bookVerse);
          textList.add(selectedList[i].bookText);
        }
      }

      /// clean up extra '-'
      if (verseList.last == '-') {
        verseList.removeLast();
      }

      /// add bible version abbreviation
      verseList.add(' (' + selectedList[0].bibleCode + ')');

      /// join the message
      message = message + verseList.join();
      message = message + '\n' + textList.join(' ');
      return message;
    }

    List<int> uniqueBooks = selectedList.map((item) => item.bookNum).toSet().toList();

    List<dynamic> message = [];
    uniqueBooks.forEach((element) {
      List<BibleView> bookItems = selectedList.where((item) => item.bookNum == element).toList();
      message.add(buildMessage(bookItems));
    });

    return message.join('\n');
  }

  void setSelectedIndex(int index) {
    setState(() {
      selectedBibleVersionIndex = index;
    });
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

  bool isSelected(int id) {
    if (selectedList.isEmpty) return false;
    return selectedList.where((item) => item.id == id).length == 1;
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
      }
    );

    return futureValue;
  }

  Widget _getRowOnly(int index, BibleView data) => InkWell(
        onTap: () {
          setState(() {
            if (isSelected(data.id)) {
              selectedList.removeWhere((item) => item.id == data.id);
            } else {
              selectedList.add(data);
            }
          });
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: isSelected(data.id)
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

  Widget _getRowWithHeading(int index, BibleView data) => Column(children: <Widget>[
        Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child:
                Text(data.bookName + ' ' + data.bookChapter.toString(), style: AppTheme.headline5)),
        _getRowOnly(index, data),
      ]);

  Widget _buildReadingView(BuildContext context) {
    return FutureBuilder(
      future: getBookContent(selectedBibleVersionIndex),
      builder: (context, snapshot) {
        if (ConnectionState.active != null && !snapshot.hasData) {
          return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(height: 30),
                Text('Loading Daily Reading'),
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
