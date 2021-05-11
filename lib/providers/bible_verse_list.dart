import 'package:flutter/material.dart';
import '../models/bible_view.dart';

class BibleVerseList with ChangeNotifier {
  BibleVerseList();

  List<BibleView> listItems = [];

  void clearList() {
    listItems.clear();
    notifyListeners();
  }

  void addRemoveItem(BibleView bibleView) {
    if (this.isSelected(bibleView.id)) {
      listItems.removeWhere((item) => item.id == bibleView.id);
    } else {
      listItems.add(bibleView);
    }
    notifyListeners();
  }

  void sortList() {
    listItems.sort((a, b) => a.id.compareTo(b.id));
  }

  bool isEmptyList() {
    return listItems.isEmpty;
  }

  bool isSelected(int id) {
    if (listItems.isEmpty) {
      return false;
    }
    return listItems.where((item) => item.id == id).length == 1;
  }

  /// Generate share/copy message function
  ///
  /// case 1: same book, same chapter, verses copied in sequence
  /// case 2: same book, same chapter, verses not in sequence
  /// case 3: same book, different chapter, verses copied in sequence
  /// case 4: same book, different chapter, verses copied not in sequence
  /// case 3: different book, verses copied in sequence
  /// case 4: different book, verses copied not in sequence
  String generateShareMessage() {
    if (listItems.length == 0) {
      return '';
    }

    /// sort the list before generating message
    this.sortList();

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

    List<int> uniqueBooks = listItems.map((item) => item.bookNum).toSet().toList();

    List<dynamic> message = [];
    uniqueBooks.forEach((element) {
      List<BibleView> bookItems = listItems.where((item) => item.bookNum == element).toList();
      message.add(buildMessage(bookItems));
    });

    return message.join('\n');
  }
}