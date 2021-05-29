import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';

import '../../app_theme.dart';
import '../../providers/bible_verse_list.dart';

class BibleBottomBar extends StatelessWidget {
  BibleBottomBar({Key key, this.bibleVerseList}) : super(key: key);

  final BibleVerseList bibleVerseList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    if (bibleVerseList.isEmptyList()) {
      return Padding(padding: const EdgeInsets.all(0));
    }
    return Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          padding: const EdgeInsets.only(left: 14, top: 2, bottom: 2),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text('${bibleVerseList.listItems.length} verse' +
                      (bibleVerseList.listItems.length > 1 ? 's selected' : ' selected')),
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
                        shareMessage = bibleVerseList.generateShareMessage();
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

                      bibleVerseList.clearList();
                    },
                  ),
                ),
              ]),
          color: AppTheme.darkGreen.withOpacity(0.8),
        ));
  }
}
