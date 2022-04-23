import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';

import '../../app_theme.dart';
import '../../providers/my_bible.dart';
import '../../providers/my_reading_item.dart';

class HomeAppBar extends StatelessWidget {
  HomeAppBar({this.date, this.myBible}) : super();
  final DateTime date;
  final MyBibleProvider myBible;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text('Daily Reading'),
        backgroundColor: AppTheme.darkGreen,
        actions: <Widget>[
          Container(
              padding: const EdgeInsets.all(0),
              child: PopupMenuButton(
                icon: FaIcon(FontAwesomeIcons.cog, size: 22, color: AppTheme.white),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'copy',
                    child: Text('Copy Summary'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'share',
                    child: Text('Share Summary'),
                  ),
                  PopupMenuDivider(),
                  const PopupMenuItem<String>(
                    value: 'copyTB',
                    child: Text('Copy Summary TB'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'copyKJV',
                    child: Text('Copy Summary KJV'),
                  ),
                  PopupMenuDivider(),
                  const PopupMenuItem<String>(
                    value: 'GEMA',
                    child: Text('GEMA'),
                  ),
                ],
                onSelected: (value) async {
                  String readingSummary;
                  if (value == 'copyTB') {
                    MyReadingItemProvider readingItem = await loadDailyReadingItem(date, 8);
                    readingSummary = readingItem.generateSummary();
                  }
                  if (value == 'copyKJV') {
                    MyReadingItemProvider readingItem = await loadDailyReadingItem(date, 4);
                    readingSummary = readingItem.generateSummary();
                  }
                  if (value == 'copy') {
                    MyReadingItemProvider readingItem =
                        await loadDailyReadingItem(date, myBible.version);
                    readingSummary = readingItem.generateSummary();
                  }
                  if (value == 'GEMA') {
                    readingSummary = await loadDailyReadingSummaryFull(date);
                  }
                  if (value != 'share') {
                    Clipboard.setData(new ClipboardData(text: readingSummary));
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                        content: const Text('Copied to clipboard'),
                        duration: const Duration(seconds: 2),
                      ));
                  }
                  if (value == 'share') {
                    Share.share(readingSummary);
                  }
                },
              ))
        ]);
  }
}
