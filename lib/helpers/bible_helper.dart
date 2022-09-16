import '../models/bible_view.dart';

String parseText(String text) {
  return text.replaceAll(new RegExp(r"\\"), "");
}

/// eg. id = 66011021
/// return is [21, 11, 66]
List<int> splitVerse(int verse) {
  String verses = verse.toString();
  List<int> verseList = [];

  /// verse number
  verseList.add(int.parse(verses.substring(verses.length - 3)));

  /// chapter number
  verseList.add(int.parse(verses.substring(verses.length - 6, verses.length - 3)));

  /// book number
  verseList.add(int.parse(verses.substring(0, verses.length - 6)));

  /// [verseNum, chapterNum, bookNum]
  return verseList;
}

int formatBibleId(int book, int chapter, int verse) {
  return int.parse(
      book.toString() + chapter.toString().padLeft(3, '0') + verse.toString().padLeft(3, '0'));
}

int formatBookChapter(int book, int chapter) {
  return int.parse(book.toString() + chapter.toString().padLeft(3, '0'));
}

Map<String, String> generateBibleVerses(List<BibleView> listItems) {
  if (listItems.length == 0) {
    return new Map();
  }

  /// sort the list before generating message
  listItems.sort((a, b) => a.id.compareTo(b.id));

  String messageHeader = '';

  /// Function to craft the message
  String buildMessage(List<BibleView> selectedList) {
    String message = selectedList[0].bookName + ' ' + selectedList[0].bookChapter.toString() + ':';
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
    messageHeader = message;
    // message = message + '\n' + textList.join(' ');
    message = '\n' + textList.join(' ');
    return message;
  }

  List<int> uniqueBooks = listItems.map((item) => item.bookNum).toSet().toList();

  List<dynamic> message = [];
  uniqueBooks.forEach((element) {
    List<BibleView> bookItems = listItems.where((item) => item.bookNum == element).toList();
    message.add(buildMessage(bookItems));
  });

  Map<String, String> map = new Map();
  map['header'] = messageHeader;
  map['body'] = message.join('\n');
  return map;
}
