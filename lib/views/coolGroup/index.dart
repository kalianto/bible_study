import 'package:flutter/material.dart';

// import '../../app_theme.dart';
import '../../common/child_page_appbar.dart';

class CoolGroup extends StatefulWidget {
  @override
  _CoolGroupState createState() => _CoolGroupState();
}

class _CoolGroupState extends State<CoolGroup> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ChildPageAppBar(title: 'COOL Group'),
                Container(
                  padding: const EdgeInsets.only(top: 50),
                  child: SingleChildScrollView(
                      child: Container(
                    padding: const EdgeInsets.all(40),
                    child: Text('The content of this page is being constructed'),
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
