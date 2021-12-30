import 'package:cool/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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

  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    setIsBookSelection(true);
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadBookChapters());
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
    MyBible myBible = Provider.of<MyBible>(context, listen: false);
    var dbClient = BookChapterProvider();
    List<BookChapter> list = await dbClient.getAllBookChapters(myBible.version);
    setState(() {
      bookChapterList = list;
      staticBookChapterList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedCrossFade(
        duration: const Duration(milliseconds: 500),
        firstChild: buildBookList(context),
        secondChild: buildChapterList(context),
        crossFadeState: isBookSelection ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      ),
    );
  }

  Widget buildBookList(BuildContext context) {
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
        shrinkWrap: true,
        itemCount: bookChapterList.length,
        itemBuilder: (context, index) {
          return Container(
              margin: const EdgeInsets.all(0),
              // decoration: BoxDecoration(
              //   color: AppTheme.nearlyDarkBlue.withOpacity(0.2),
              //   borderRadius: AppTheme.borderRadius,
              // ),
              child: Column(children: <Widget>[
                ListTile(
                  leading: bookChapterList[index].bookId < 40
                      ? FaIcon(FontAwesomeIcons.bible)
                      : FaIcon(FontAwesomeIcons.cross),
                  title: Text(
                    bookChapterList[index].bookName,
                    style: AppTheme.headline6,
                  ),
                  dense: true,
                  onTap: () {
                    setBookChapter(bookChapterList[index]);
                    setIsBookSelection(false);
                  },
                ),
                Divider(),
              ]));
        });

    return Stack(children: [
      searchBar,
      Container(padding: const EdgeInsets.only(top: 60), child: bookSelectionList),
    ]);
  }

  Widget buildChapterList(BuildContext context) {
    MyBible myBible = Provider.of<MyBible>(context, listen: false);

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
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.all(6),
          margin: const EdgeInsets.all(10),
          decoration: AppTheme.boxDecoration,
          child: InkWell(
            child: Center(
              child: Text('${index + 1}', style: AppTheme.headline5),
            ),
            onTap: () {
              int selectedChapter =
                  BibleHelper.formatBibleId(selectedBookChapter.bookId, index + 1, 1);
              myBible.saveMyBibleLastVerse(selectedChapter);
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
