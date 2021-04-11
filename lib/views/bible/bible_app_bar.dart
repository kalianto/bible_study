import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_theme.dart';
import '../../app_config.dart';
import '../../models/bible_version.dart';
import '../../providers/bible_version.dart';
import '../../models/daily_reading.dart';

class BibleAppBar extends StatefulWidget {
  BibleAppBar({Key key, this.dailyReadingItem, this.selectedIndex, this.setSelectedIndex})
      : super(key: key);

  final DailyReading dailyReadingItem;
  final int selectedIndex;
  final setSelectedIndex;

  @override
  _BibleAppBarState createState() => _BibleAppBarState();
}

class _BibleAppBarState extends State<BibleAppBar> {
  double topBarOpacity = 1.0;

  int selectedBibleIndex;
  @override
  void initState() {
    super.initState();
    selectedBibleIndex = widget.selectedIndex;
  }

  void saveBibleVersion(int bibleVersionId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = AppConfig.bibleVersion;
    prefs.setInt(key, bibleVersionId);
  }

  Widget buildBibleVersion(BuildContext context) {
    return FutureBuilder(
        future: getBibleVersion(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (ConnectionState.active != null && !snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return InkWell(
              onTap: () {
                _showBibleVersionDialog(context, snapshot.data);
              },
              child: Chip(
                  backgroundColor: AppTheme.blueText.withOpacity(0.8),
                  label: Text(
                    snapshot.data[widget.selectedIndex - 1].abbreviation,
                    style: TextStyle(color: AppTheme.nearlyWhite, fontWeight: FontWeight.w600),
                  )));
        });
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

  _showBibleVersionDialog(BuildContext context, List<BibleVersion> data) {
    SimpleDialog dialog = SimpleDialog(
      title: const Text('Select Bible Version'),
      children: _generateBibleVersionDialogItem(context, data),
    );

    Future futureValue = showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });

    futureValue.then((bibleVersion) {
      if (bibleVersion != null) {
        /// TODO: Should we do it here???
        /// Reason we do it here because the interface to update it is here
        setState(() {
          saveBibleVersion(bibleVersion);
          widget.setSelectedIndex(bibleVersion);
          selectedBibleIndex = bibleVersion;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                top: 16 - 8.0 * topBarOpacity,
                bottom: 12 - 8.0 * topBarOpacity),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: const Icon(FontAwesomeIcons.arrowLeft),
                  iconSize: 22,
                  onPressed: () => Navigator.pop(context, widget.selectedIndex),
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                  color: AppTheme.darkGrey,
                ),
                Expanded(
                    child:
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                  Flexible(
                    // padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(widget.dailyReadingItem.shortSummary(),
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
                  buildBibleVersion(context),
                ])),
              ],
            ),
          )
        ],
      ),
    );
  }
}
