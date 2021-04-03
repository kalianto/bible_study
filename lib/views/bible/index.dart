import 'package:bible_study/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';

import '../../models/bible_view.dart';
import '../../models/bible_version.dart';
import '../../models/daily_reading.dart';
import '../../providers/bible_view.dart';
import '../../providers/bible_version.dart';

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

  List<BibleVersion> bibleVersionList = List();
  int selectedBibleVersionIndex = 1;

  List<BibleView> selectedList = List();

  @override
  void initState() {
    super.initState();
    scrollController = AutoScrollController(
        viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);
    // bibleVersionList =
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
                        // Share.share(shareMessage);
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

  String _generateShareMessage(List<BibleView> selectedList) {
    String message = '';
    if (selectedList.length == 0) {
      return message;
    }
    List<String> uniqueChapters = selectedList
        .map((item) => item.bookNum.toString() + item.bookChapter.toString())
        .toSet()
        .toList();

    /// case 1: same book, same chapter, verses copied in sequence
    /// case 2: same book, same chapter, verses not in sequence
    /// case 3: same book, different chapter, verses copied in sequence
    /// case 4: same book, different chapter, verses copied not in sequence
    /// case 3: different book, verses copied in sequence
    /// case 4: different book, verses copied not in sequence
    message = message +
        selectedList[0].bookName +
        ' ' +
        selectedList[0].bookChapter.toString() +
        ':';

    List<dynamic> verseList = new List();
    List<String> textList = new List();

    if (uniqueChapters.length == 1) {
      verseList.add(selectedList[0].bookVerse);
      textList.add(selectedList[0].bookText);
      verseList.add('-');
      for (var i = 1; i < selectedList.length; i++) {
        if ((selectedList[i].bookVerse - selectedList[i-1].bookVerse) == 1) {
          if (verseList.last is int) {
            if (verseList[verseList.length - 2] == '-') {
              verseList.removeLast();
            } else if (verseList[verseList.length - 2] == ',') {
              verseList.add('-');
            }
          }
          verseList.add(selectedList[i].bookVerse);
          textList.add(selectedList[i].bookText);
        } else {
          if (verseList.last == '-') {
            verseList.removeLast();
          }
          verseList.add(',');
          verseList.add(selectedList[i].bookVerse);
          textList.add(selectedList[i].bookText);
        }
      }
      message = message + verseList.join();
      // message = message + '\n' + textList.join(' ');
    } else {

    }
    print(message);
    return message;
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
                left: 10,
                right: 10,
                top: 16 - 8.0 * topBarOpacity,
                bottom: 12 - 8.0 * topBarOpacity),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: const Icon(FontAwesomeIcons.arrowLeft),
                  iconSize: 22,
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                  color: AppTheme.darkGrey,
                ),
                Expanded(
                    child:
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                  Flexible(
                    // padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(widget.readingItem.shortSummary(),
                          //textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: AppTheme.fontName,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            letterSpacing: 1.2,
                            color: AppTheme.darkGrey,
                          )),
                    ),
                  ),
                  buildBibleVersion(context),
                ])),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildBibleVersion(BuildContext context) {
    return FutureBuilder(
        future: getBibleVersion(),
        builder: (context, snapshot) {
          if (ConnectionState.active != null && !snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Align(
            alignment: Alignment.centerRight,
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
              value: selectedBibleVersionIndex,
              items: snapshot.data.map<DropdownMenuItem<int>>((item) {
                return DropdownMenuItem<int>(
                    child: Text(item.abbreviation, style: AppTheme.headline6), value: item.id);
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedBibleVersionIndex = value;
                });
              },
            )),
          );
        });
  }

  Future<List<BibleVersion>> getBibleVersion() async {
    var dbClient = BibleVersionProvider();
    List<BibleVersion> bibleVersionList = await dbClient.getAllBibleVersion();
    return bibleVersionList;
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
              Expanded(child: Text(data.bookText, style: AppTheme.body1)),
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
