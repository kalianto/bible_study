import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../app_theme.dart';
import '../../providers/my_bible.dart';
import '../../providers/my_reading_item.dart';

class HomeAppBar extends StatelessWidget {

  HomeAppBar({this.date, this.myBible}) : super();
  final DateTime date;
  final MyBible myBible;

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
                ],
                onSelected: (value) async {
                  MyReadingItem readingItem = await loadDailyReadingItem(date, myBible.version);
                  String readingSummary = readingItem.generateSummary();
                  if (value == 'copy') {
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
