import 'package:cool/models/book_chapter.dart';
import 'package:flutter/material.dart';

import '../../app_theme.dart';
import '../../helpers/bible_helper.dart' as BibleHelper;
import '../../providers/my_bible.dart';
import '../../services/book_chapter.dart';

class BibleAppBarTitle extends StatelessWidget {
  BibleAppBarTitle({Key key, this.myBible, this.action}) : super(key: key);

  final MyBible myBible;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getBookChapter(myBible),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (ConnectionState.active != null && !snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return buildAppBarTitle(context, snapshot.data);
        });
  }

  Widget buildAppBarTitle(BuildContext context, data) {
    return InkWell(
      onTap: () {
        action();
      },
      child: Chip(
          backgroundColor: AppTheme.blueText.withOpacity(0.8),
          label: Text(data,
              style: TextStyle(
                fontFamily: AppTheme.fontName,
                fontWeight: FontWeight.w400,
                fontSize: 18,
                letterSpacing: 1.2,
                color: AppTheme.nearlyWhite,
              ))),
    );
  }
}

Future<String> getBookChapter(MyBible myBible) async {
  List<int> verses = BibleHelper.splitVerse(myBible.lastBibleVerse);
  int bookId = verses[2];
  var dbClient = BookChapterService();
  BookChapter bookChapter = await dbClient.getBookChapter(myBible.version, bookId);
  return bookChapter.bookName + ' ' + verses[1].toString();
}
