import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';

import '../../app_theme.dart';
import '../../models/bible_view.dart';


class BibleBottomBar extends StatefulWidget {
  @override
  _BibleBottomBarState createState() => _BibleBottomBarState();
}

class _BibleBottomBarState extends State<BibleBottomBar> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 60),
      child: _buildBottomNavigationBar(context),
    );
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
}
