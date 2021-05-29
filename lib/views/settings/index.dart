import 'package:flutter/material.dart';

import '../../common/child_page_appbar.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildPage(context),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Stack(
      children: <Widget>[
        ChildPageAppBar(title: 'Settings'),
        Container(
          padding: const EdgeInsets.only(top: 50),
          child: SingleChildScrollView(),
        ),
      ],
    );
  }
}
