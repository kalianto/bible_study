import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../app_theme.dart';
import '../../common/bottom_gnav_bar.dart';
import 'drawer.dart';
import 'daily_reading.dart';
import 'today_reading.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AnimationController animationController;
  Animation<double> topBarAnimation;
  double topBarOpacity = 1.0;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    animationController =
        AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController, curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 && scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });

    super.initState();
  }

  // opening the home drawer
  void _openHomeDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            // Container(
            //   height: MediaQuery.of(context).size.width / 2,
            //   width: MediaQuery.of(context).size.width,
            //   color: AppTheme.purple,
            // ),
            homeAppBar(),
            TodayReading(),
            // DailyReading(
            //     scrollController: scrollController, animationController: animationController),
            // SizedBox(
            //   height: MediaQuery.of(context).padding.bottom,
            // )
          ],
        ),
        drawer: HomeDrawer(),
        bottomNavigationBar: BottomGNavBar(),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.add),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // backgroundColor: Colors.black,
      ),
    );
  }

  Widget homeAppBar() {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10, //MediaQuery.of(context).padding.top,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16 - 8.0 * topBarOpacity,
                bottom: 12 - 8.0 * topBarOpacity),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 38,
                  width: 38,
                  child: IconButton(
                    icon: const Icon(FontAwesomeIcons.bars),
                    onPressed: _openHomeDrawer,
                    tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                    color: AppTheme.purple,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Daily Reading',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontWeight: FontWeight.w600,
                        fontSize: 22 + 6 - 6 * topBarOpacity,
                        letterSpacing: 1.2,
                        color: AppTheme.purple,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
