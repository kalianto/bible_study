import 'package:flutter/material.dart';

import '../../common/child_page_appbar.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ChildPageAppBar(title: 'My Notes'),
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
      )),
    );
  }
}
