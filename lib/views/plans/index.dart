import 'package:flutter/material.dart';

// import '../../app_theme.dart';
import '../../common/child_page_appbar.dart';

class ReadingPlans extends StatefulWidget {
  @override
  _ReadingPlansState createState() => _ReadingPlansState();
}

class _ReadingPlansState extends State<ReadingPlans> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ChildPageAppBar(title: 'Reading Plans'),
                Container(
                  padding: const EdgeInsets.only(top: 50),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(40),
                      child: Text('The content of this page is being constructed'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
