import 'package:flutter/material.dart';

// import '../../app_theme.dart';
import '../../common/child_page_appbar.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ChildPageAppBar(title: 'News'),
                  Container(
                    padding: const EdgeInsets.only(top: 50),
                    child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(40),
                          child: Text('The content of this page is being constructed'),
                        )
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
