// import 'package:cool/providers/bible_verse_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';

// import '../../app_config.dart';
import '../../models/bible_version.dart';
import '../../services/bible_version.dart';
import '../../models/daily_reading.dart';
import '../../providers/my_bible.dart';

class BibleAppBar extends StatelessWidget {
  BibleAppBar({Key key, this.title}) : super(key: key);

  final String title;

  Widget buildBibleVersion(BuildContext context, data, myBible) {
    return InkWell(
        onTap: () {
          _showBibleVersionDialog(context, data, myBible);
        },
        child: Chip(
            backgroundColor: AppTheme.blueText.withOpacity(0.8),
            label: Text(
              data.firstWhere((item) => item.id == myBible.version)?.abbreviation,
              style: TextStyle(color: AppTheme.nearlyWhite, fontWeight: FontWeight.w600),
            )));
  }

  Future<List<BibleVersion>> getBibleVersion() async {
    var dbClient = BibleVersionProvider();
    List<BibleVersion> bibleVersionList = await dbClient.getAllBibleVersion();
    return bibleVersionList;
  }

  List<SimpleDialogOption> _generateBibleVersionDialogItem(
      BuildContext context, List<BibleVersion> data) {
    return List.generate(
        data.length,
        (i) => SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, data[i].id);
              },
              child: Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    child: Text(data[i].abbreviation),
                  ),
                  Padding(padding: const EdgeInsets.all(10), child: Text(data[i].version)),
                ],
              ),
            ));
  }

  _showBibleVersionDialog(BuildContext context, List<BibleVersion> data, MyBible myBible) {
    SimpleDialog dialog = SimpleDialog(
      title: const Text('Select Bible Version'),
      children: _generateBibleVersionDialogItem(context, data),
    );

    Future futureValue = showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });

    futureValue.then((bibleVersion) async {
      if (bibleVersion != null) {
        await myBible.saveMyBibleVersion(bibleVersion);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getBibleVersion(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (ConnectionState.active != null && !snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            decoration: BoxDecoration(
              color: AppTheme.darkGrey.withOpacity(0.4),
            ),
            height: 60,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 6,
                    bottom: 6,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Consumer<MyBible>(builder: (context, myBible, child) {
                        return IconButton(
                          icon: const Icon(FontAwesomeIcons.arrowLeft),
                          iconSize: 22,
                          onPressed: () => Navigator.pop(context, myBible.version),
                          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                          color: AppTheme.darkGrey,
                        );
                      }),
                      Expanded(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                            Flexible(
                              // padding: const EdgeInsets.all(8.0),
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(title,
                                    //textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontFamily: AppTheme.fontName,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      letterSpacing: 1.2,
                                      color: AppTheme.darkGrey,
                                    )),
                              ),
                            ),
                            Consumer<MyBible>(builder: (context, myBible, child) {
                              return buildBibleVersion(context, snapshot.data, myBible);
                            }),
                          ])),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
