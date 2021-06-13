import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';
import '../../providers/my_bible.dart';
import 'bible_version_dialog.dart';

class BibleAppBar extends StatelessWidget {
  BibleAppBar({Key key, this.title}) : super(key: key);

  final String title;

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
                              return BibleVersionDialog(data: snapshot.data, myBible: myBible);
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
