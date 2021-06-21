import 'package:cool/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../services/book_chapter.dart';
import '../../models/book_chapter.dart';
import '../../providers/my_bible.dart';

class BibleSelectorDrawer extends StatefulWidget {
  @override
  _BibleSelectorDrawerState createState() => _BibleSelectorDrawerState();
}

class _BibleSelectorDrawerState extends State<BibleSelectorDrawer> {
  bool isBookSelection = true;
  List<BookChapter> bookChapterList = [];
  BookChapter selectedBookChapter;

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
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: bookChapterList.length,
      itemBuilder: (context, index) {
        return Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppTheme.nearlyDarkBlue.withOpacity(0.2),
              borderRadius: AppTheme.borderRadius,
            ),
            child: ListTile(
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
            ));
      },
    );
  }

  Widget buildChapterList(BuildContext context) {
    MyBible myBible = Provider.of<MyBible>(context, listen: false);
    if (selectedBookChapter != null) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemCount: selectedBookChapter.chapters.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: AppTheme.boxDecoration,
              child: InkWell(
                child: Center(
                child: Text('${index+1}', style: AppTheme.headline5),
              ), onTap: () {
                  int selectedChapter = myBible.formatBibleId(selectedBookChapter.bookId, index+1, 1);
                  myBible.saveMyBibleLastVerse(selectedChapter);
                  // myBible.updateBookChapterText(selectedBookChapter.bookName + ' ' + (index + 1).toString());
                  Navigator.of(context).pop();
              },),

          );
        },
      );
    }
    return Container(
        child: Center(
      child: Text('Please select a book first'),
    ));
  }
}
