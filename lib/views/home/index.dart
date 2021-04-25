import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';
import 'drawer.dart';
// import 'daily_reading.dart';
import 'daily_reading_item.dart';
import '../../models/daily_reading.dart';
import '../../models/my_bible_version.dart';
import '../../providers/daily_reading.dart';
import 'date_selector.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // AnimationController animationController;
  // Animation<double> topBarAnimation;
  double topBarOpacity = 1.0;
  // final ScrollController scrollController = ScrollController();

  DateTime date;

  @override
  void initState() {
    super.initState();
    // animationController =
    //     AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    // topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //     parent: animationController, curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    // scrollController.addListener(() {
    //   if (scrollController.offset >= 24) {
    //     if (topBarOpacity != 1.0) {
    //       setState(() {
    //         topBarOpacity = 1.0;
    //       });
    //     }
    //   } else if (scrollController.offset <= 24 && scrollController.offset >= 0) {
    //     if (topBarOpacity != scrollController.offset / 24) {
    //       setState(() {
    //         topBarOpacity = scrollController.offset / 24;
    //       });
    //     }
    //   } else if (scrollController.offset <= 0) {
    //     if (topBarOpacity != 0.0) {
    //       setState(() {
    //         topBarOpacity = 0.0;
    //       });
    //     }
    //   }
    // });

    date = new DateTime.now();
  }

  void setDate(DateTime newDate) {
    setState(() {
      date = newDate;
    });
  }

  /// opening the home drawer
  // void _openHomeDrawer() {
  //   _scaffoldKey.currentState.openDrawer();
  // }

  @override
  void dispose() {
    // animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureProvider<MyBibleVersion>(
        initialData: MyBibleVersion(),
        create: (context) => loadMyBibleVersion(),
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text('Daily Reading'),
              backgroundColor: AppTheme.darkGreen,
              actions: <Widget>[
                Consumer<MyBibleVersion>(builder: (context, myBibleVersion, child) {
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
                          await getDailyReadingSummary(date, myBibleVersion.version);
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
            body: SingleChildScrollView(
              child: Column(
              children: <Widget>[
                // homeAppBar(),
                Consumer<MyBibleVersion>(
                  builder: (context, myBibleVersion, child) {
                    return buildHomeContent(context, myBibleVersion);
                  },
                ),
                // Consumer<MyBibleVersion>(
                //   builder: (context, myBibleVersion, child) {
                //     return buildHomeContent(context, myBibleVersion);
                //   },
                // ),
              ],
            )),
            drawer: HomeDrawer(),
          ),
        ));
  }

  Widget buildHomeContent(BuildContext context, MyBibleVersion myBibleVersion) {
    return Container(
        padding: const EdgeInsets.only(top: 16, bottom: 0),
        //child: SingleChildScrollView(
          child: Column(children: <Widget>[
            DateSelector(date: date, setDate: setDate),
            Container(
                child: new DailyReadingItem(
                    bibleVersionIndex: myBibleVersion.version,
                    date: date,
                    setBibleVersion: myBibleVersion.saveMyBibleVersion)),
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

  // Widget homeAppBar() {
  //   return Container(
  //     child: Column(
  //       children: <Widget>[
  //         SizedBox(
  //           height: 10, //MediaQuery.of(context).padding.top,
  //         ),
  //         Padding(
  //           padding: EdgeInsets.only(
  //               left: 16,
  //               right: 16,
  //               top: 16 - 8.0 * topBarOpacity,
  //               bottom: 12 - 8.0 * topBarOpacity),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               SizedBox(
  //                 height: 38,
  //                 width: 38,
  //                 child: IconButton(
  //                   icon: const Icon(FontAwesomeIcons.bars),
  //                   onPressed: _openHomeDrawer,
  //                   tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
  //                   color: AppTheme.purple,
  //                 ),
  //               ),
  //               Expanded(
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(10.0),
  //                   child: Text(
  //                     'Daily Reading',
  //                     textAlign: TextAlign.left,
  //                     style: TextStyle(
  //                       fontFamily: AppTheme.fontName,
  //                       fontWeight: FontWeight.w600,
  //                       fontSize: 22 + 6 - 6 * topBarOpacity,
  //                       letterSpacing: 1.2,
  //                       color: AppTheme.purple,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               Consumer<MyBibleVersion>(builder: (context, myBibleVersion, child) {
  //                 return Container(
  //                     padding: const EdgeInsets.all(0),
  //                     child: PopupMenuButton(
  //                       icon: FaIcon(FontAwesomeIcons.cog, size: 22, color: AppTheme.purple),
  //                       itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
  //                         const PopupMenuItem<String>(
  //                           value: 'copy',
  //                           child: Text('Copy Summary'),
  //                         ),
  //                         const PopupMenuItem<String>(
  //                           value: 'share',
  //                           child: Text('Share Summary'),
  //                         ),
  //                       ],
  //                       onSelected: (value) async {
  //                         List<DailyReading> listItems =
  //                             await getDailyReadingSummary(date, myBibleVersion.version);
  //                         String readingSummary =
  //                             List.generate(listItems.length, (i) => listItems[i].shortSummary())
  //                                 .join('\n');
  //                         if (value == 'copy') {
  //                           Clipboard.setData(new ClipboardData(text: readingSummary));
  //                           ScaffoldMessenger.of(context)
  //                             ..removeCurrentSnackBar()
  //                             ..showSnackBar(SnackBar(
  //                               content: const Text('Copied to clipboard'),
  //                               duration: const Duration(seconds: 2),
  //                             ));
  //                         }
  //                         if (value == 'share') {
  //                           Share.share(readingSummary);
  //                         }
  //                       },
  //                     ));
  //               })
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Future<List<DailyReading>> getDailyReadingSummary(DateTime date, int bibleVersionId) async {
    var dbClient = DailyReadingProvider();
    List<DailyReading> dailyReadingList =
        await dbClient.getDailyReading(date, bibleVersionId: bibleVersionId);
    return dailyReadingList;
  }
}

