import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';
import 'date_selector.dart';
import 'drawer.dart';
import 'daily_reading_item.dart';
import '../../models/daily_reading.dart';
import '../../common/my_bible.dart';
import '../../providers/daily_reading.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double topBarOpacity = 1.0;

  DateTime date;

  @override
  void initState() {
    super.initState();
    date = new DateTime.now();
  }

  void setDate(DateTime newDate) {
    setState(() {
      date = newDate;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Daily Reading'),
          backgroundColor: AppTheme.darkGreen,
          actions: <Widget>[
            Consumer<MyBible>(builder: (context, myBible, child) {
              return Container(
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
                      List<DailyReading> listItems =
                          await getDailyReadingSummary(date, myBible.version);
                      String readingSummary =
                          List.generate(listItems.length, (i) => listItems[i].shortSummary())
                              .join('\n');
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
                  ));
            })
          ],
        ),
        key: _scaffoldKey,
        body: Consumer<MyBible>(
          builder: (context, myBible, child) {
            return buildHomeContent(context, myBible);
          },
        ),
        drawer: HomeDrawer(),
      ),
    );
  }

  Widget buildHomeContent(BuildContext context, MyBible myBible) {
    return Container(
        padding: const EdgeInsets.only(top: 16, bottom: 0),
        //child: SingleChildScrollView(
        child: Column(children: <Widget>[
          DateSelector(date: date, setDate: setDate),
          Container(
              child: new DailyReadingItem(
                  bibleVersionIndex: myBible.version,
                  date: date,
                  setBibleVersion: myBible.saveMyBibleVersion)),
          SizedBox(height: 20),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                Text('Rhema',
                    style: TextStyle(
                        color: AppTheme.darkGrey, fontSize: 18, fontWeight: FontWeight.w600)),
              ])),
        ]));
    //));
  }

  Future<List<DailyReading>> getDailyReadingSummary(DateTime date, int bibleVersionId) async {
    var dbClient = DailyReadingProvider();
    List<DailyReading> dailyReadingList =
        await dbClient.getDailyReading(date, bibleVersionId: bibleVersionId);
    return dailyReadingList;
  }
}
