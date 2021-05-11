import 'file:///C:/Kal/dev/flutter/bible_study/lib/providers/my_bible.dart';
import 'package:cool/views/bible/bible_app_bar.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

// import '../../app_theme.dart';
// import '../../app_config.dart';
// import 'bible_content.dart';

class BiblePage extends StatefulWidget {
  @override
  _BiblePageState createState() => _BiblePageState();
}

class _BiblePageState extends State<BiblePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Consumer<MyBible>(builder: (context, myBible, child) {
          return Expanded(
            child: Column(
              children: <Widget>[
                new BibleAppBar(

                ),
                // new BibleContent(
                //
                // ),
              ]
            )
          );
        }),// BibleContent(),
      )
    );
  }
}
