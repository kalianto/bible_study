import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/my_bible.dart';
import 'daily_reading_item.dart';
import 'date_selector.dart';
import 'drawer.dart';
import 'home_app_bar.dart';
import 'rhema.dart';

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
    return Consumer<MyBible>(builder: (context, myBible, child) {
      return SafeArea(
          child: Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: HomeAppBar(date: date, myBible: myBible),
        ),
        body: buildHomeContent(context, myBible),
        drawer: HomeDrawer(),
      ));
    });
  }

  Widget buildHomeContent(BuildContext context, MyBible myBible) {
    return Container(
        padding: const EdgeInsets.only(top: 16, bottom: 0),
        child: Column(children: <Widget>[
          DateSelector(date: date, setDate: setDate),
          DailyReadingItem(date: date, myBible: myBible),
          SizedBox(height: 20),
          Rhema(),
        ]));
  }
}
