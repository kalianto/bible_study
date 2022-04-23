import 'package:cool/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../helpers/bible_helper.dart' as BibleHelper;
import '../../models/book_chapter.dart';
import '../../providers/my_bible.dart';
import '../../services/book_chapter.dart';

class BibleSelectorDrawer extends StatefulWidget {
  @override
  _BibleSelectorDrawerState createState() => _BibleSelectorDrawerState();
}

class _BibleSelectorDrawerState extends State<BibleSelectorDrawer> {
  bool isBookSelection = true;
  List<BookChapter> bookChapterList = [];
  List<BookChapter> staticBookChapterList = [];
  BookChapter selectedBookChapter;
  AutoScrollController scrollController;

  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    setIsBookSelection(true);
    scrollController = AutoScrollController(
        viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);

    WidgetsBinding.instance.addPostFrameCallback((_) => _loadSelectionDrawers(context));
  }

  void setBookChapter(BookChapter bookChapter) {
    setState(() {
      selectedBookChapter = bookChapter;
    });
  }

  void setIsBookSelection(bool bookSelection) {
    setState(() {
      isBookSelection = bookSelection;
    });
  }

  Future<void> _loadBookChapters() async {
    MyBibleProvider myBible = Provider.of<MyBibleProvider>(context, listen: false);
    var dbClient = BookChapterService();
    List<BookChapter> list = await dbClient.getAllBookChapters(myBible.version);
    setState(() {
      bookChapterList = list;
      staticBookChapterList = list;
    });
  }

  Future _scrollToIndex(context) async {
    MyBibleProvider myBible = Provider.of<MyBibleProvider>(context, listen: false);
    int index = myBible.lastBibleVerseArray['book'] - 1;
    await scrollController.scrollToIndex(index, preferPosition: AutoScrollPosition.begin);
    scrollController.highlight(index);
  }

  Future _loadSelectionDrawers(BuildContext context) {
    _loadBookChapters();
    _scrollToIndex(context);
  }

  Widget _wrapScrollTag({int index, Widget child}) => AutoScrollTag(
        key: ValueKey(index),
        controller: scrollController,
        index: index,
        child: child,
        highlightColor: AppTheme.darkGrey.withOpacity(0.5),
      );

  @override
  Widget build(BuildContext context) {
    // setIsBookSelection(false);
    MyBibleProvider myBible = Provider.of<MyBibleProvider>(context, listen: false);

    return Container(
      child: AnimatedCrossFade(
        duration: const Duration(milliseconds: 500),
        firstChild: buildBookList(context, myBible),
        secondChild: buildChapterList(context, myBible),
        crossFadeState: isBookSelection ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      ),
    );
  }

  Widget buildBookList(BuildContext context, MyBibleProvider myBible) {
    List selectedBibleVerse = BibleHelper.splitVerse(myBible.lastBibleVerse);

    Widget searchBar = Container(
        height: 60,
        // padding: const EdgeInsets.only(top: 20),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: AppTheme.inputBorderless,
            focusedBorder: AppTheme.inputBorderless,
            border: AppTheme.inputBorderless,
            filled: true,
            fillColor: AppTheme.notWhite,
            hintText: 'Search',
            // labelText: 'Search',
          ),
          onChanged: (value) {
            var searchBookChapter = staticBookChapterList;
            if (value == '') {
              setState(() {
                bookChapterList = searchBookChapter;
              });
            } else {
              setState(() {
                bookChapterList = searchBookChapter
                    .where((f) => f.bookName.toLowerCase().contains(value.toLowerCase()))
                    .toList();
              });
            }
          },
        ));

    ListView bookSelectionList = ListView.builder(
        padding: const EdgeInsets.all(0),
        scrollDirection: Axis.vertical,
        controller: scrollController,
        shrinkWrap: true,
        itemCount: bookChapterList.length,
        itemBuilder: (context, bookIndex) {
          bool isSelected = bookChapterList[bookIndex].bookId == selectedBibleVerse[2];
          return _wrapScrollTag(
              index: bookIndex,
              child: Column(children: <Widget>[
                Container(
                    color: isSelected
                        ? AppTheme.deactivatedText.withOpacity(0.2)
                        : AppTheme.white.withOpacity(0),
                    child: ListTile(
                      leading: bookChapterList[bookIndex].bookId < 40
                          ? FaIcon(FontAwesomeIcons.bible)
                          : FaIcon(FontAwesomeIcons.cross),
                      title: Text(
                        bookChapterList[bookIndex].bookName,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                          fontSize: 18,
                          letterSpacing: -0.5,
                        ),
                      ),
                      // dense: true,
                      onTap: () {
                        setBookChapter(bookChapterList[bookIndex]);
                        setIsBookSelection(false);
                      },
                    )),
                // Divider(),
              ]));
        });

    return Stack(children: [
      searchBar,
      Container(padding: const EdgeInsets.only(top: 60), child: bookSelectionList),
    ]);
  }

  Widget buildChapterList(BuildContext context, MyBibleProvider myBible) {
    Widget emptyContainer = Container(
        child: Center(
      child: Text('Please select a book first'),
    ));

    // Widget returnBar = Container(
    //     height: 60,
    //     child: TextButton.icon(
    //       icon: const Icon(FontAwesomeIcons.arrowLeft, color: AppTheme.deactivatedText),
    //       onPressed: () {
    //         setIsBookSelection(true);
    //       },
    //       label: Text(
    //         '',
    //         textAlign: TextAlign.right,
    //         style: TextStyle(
    //           fontFamily: AppTheme.fontName,
    //           fontWeight: FontWeight.w700,
    //           fontSize: 20,
    //           letterSpacing: 1.2,
    //           color: AppTheme.deactivatedText,
    //         ),
    //       ),
    //     ));
    Widget returnBar = IconButton(
      icon: const Icon(FontAwesomeIcons.arrowLeft),
      iconSize: 22,
      onPressed: () => setIsBookSelection(true),
      tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      color: AppTheme.darkGrey,
    );

    GridView chapterSelection = GridView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemCount: selectedBookChapter?.chapters?.length,
      itemBuilder: (BuildContext context, int chapterIndex) {
        return Container(
          padding: const EdgeInsets.all(6),
          margin: const EdgeInsets.all(10),
          decoration: AppTheme.boxDecoration,
          child: InkWell(
            child: Center(
              child: Text('${chapterIndex + 1}', style: AppTheme.headline5),
            ),
            onTap: () {
              BookChapter prevBookChapter;
              int selectedChapter =
                  BibleHelper.formatBibleId(selectedBookChapter.bookId, chapterIndex + 1, 1);
              myBible.saveMyBibleLastVerse(selectedChapter);
              int prevChapter = chapterIndex - 1;
              if (prevChapter < 0) {
                prevChapter =
                    staticBookChapterList.indexWhere((f) => f.bookId == selectedBookChapter.bookId);
                // the first book,
                if (prevChapter > 0) {
                  prevBookChapter = staticBookChapterList.elementAt((prevChapter - 1));
                }
                print('Prev Book Chapter');
                print(prevBookChapter);
              }
              int nextChapter = chapterIndex + 1;
              // myBible.updateBookChapterText(selectedBookChapter.bookName + ' ' + (index + 1).toString());
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );

    return selectedBookChapter != null
        ? Stack(children: [
            returnBar,
            Container(
              padding: const EdgeInsets.only(top: 40),
              child: Center(child: Text(selectedBookChapter.bookName, style: AppTheme.headline6)),
              height: 140,
            ),
            Container(padding: const EdgeInsets.only(top: 120), child: chapterSelection),
          ])
        : emptyContainer;
  }
}
