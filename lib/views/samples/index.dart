import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../app_theme.dart';
import '../../common/child_page_appbar.dart';

class SamplePages extends StatefulWidget {
  @override
  _SamplePagesState createState() => _SamplePagesState();
}

class _SamplePagesState extends State<SamplePages> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Stack(
      children: <Widget>[
        Container(
          height: 245,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppTheme.purple,
          ),
        ),
        ChildPageAppBar(title: 'Sample Pages', textColor: AppTheme.white),
        buildPageContent(context),
      ],
    )));
  }

  Widget buildPageContent(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        buildCategoriesList(context),
        SizedBox(height: 10),
        buildInfoBox(context),
      ],
    ));
  }

  Widget buildInfoBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.purple,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Keep it up!',
                      style: TextStyle(fontWeight: FontWeight.w600, color: AppTheme.notWhite)),
                  SizedBox(height: 6),
                  Text(
                    'You have completed 6 readings this week',
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: AppTheme.lightGrey, fontSize: 12),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.cyan,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: FaIcon(
                FontAwesomeIcons.arrowRight,
                color: AppTheme.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoriesList(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 24, right: 24),
      child: Column(children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Text('List of pages for quick view', style: TextStyle(color: AppTheme.notWhite)),
        ]),
        SizedBox(height: 30),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Text('Categories',
              style:
                  TextStyle(color: AppTheme.notWhite, fontSize: 18, fontWeight: FontWeight.w600)),
        ]),
        Container(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: buildCategoriesWidget(context)),
        )
      ]),
    );
  }

  List<Widget> buildCategoriesWidget(BuildContext context) {
    var listItems = [
      {'icon': FaIcon(FontAwesomeIcons.powerOff, color: AppTheme.yellowText), 'text': 'Login'},
      {'icon': FaIcon(FontAwesomeIcons.registered, color: AppTheme.yellowText), 'text': 'Register'},
      {'icon': FaIcon(FontAwesomeIcons.infinity, color: AppTheme.yellowText), 'text': 'Privacy'},
      {'icon': FaIcon(FontAwesomeIcons.copyright, color: AppTheme.yellowText), 'text': 'Terms'},
    ];
    List<Widget> widgets = <Widget>[];
    for (var element in listItems) {
      widgets.add(new Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.all(6),
          // margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppTheme.blueText.withOpacity(0.8),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: IconButton(
            icon: element['icon'],
            onPressed: null,
            iconSize: 28,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(element['text'],
              style:
                  TextStyle(fontSize: 12, color: AppTheme.lightGrey, fontWeight: FontWeight.w400)),
        )
      ]));
    }
    return widgets;
  }
}
