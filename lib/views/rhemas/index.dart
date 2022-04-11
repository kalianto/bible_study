import 'package:flutter/material.dart';

import '../../app_theme.dart';
import '../../common/child_page_appbar.dart';

class RhemaPage extends StatefulWidget {
  @override
  _RhemaPageState createState() => _RhemaPageState();
}

class _RhemaPageState extends State<RhemaPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ChildPageAppBar(title: 'RHEMA'),
              // Container(
              //   padding: const EdgeInsets.only(top: 50),
              //   child: SingleChildScrollView(
              //       child: Container(
              //     padding: const EdgeInsets.all(40),
              //     child: Text('The content of this page is being constructed'),
              //   )),
              // ),
              Container(
                  padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        buildRhemaHeader(context),
                        SizedBox(height: 20),
                        buildRhemaContent(context),
                      ])),
            ],
          ),
        ),
      )),
    );
  }

  Widget buildRhemaHeader(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          Text('Rhema',
              style:
                  TextStyle(color: AppTheme.darkGrey, fontSize: 20, fontWeight: FontWeight.w500)),
          Text('View All',
              style:
                  TextStyle(color: AppTheme.blueText, fontSize: 14, fontWeight: FontWeight.w500)),
        ]);
  }

  Widget buildRhemaContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: AppTheme.boxShadowless,
      child: Text('Rhema'),
    );
  }
}
