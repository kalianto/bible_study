import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../app_theme.dart';

class ReadingItem extends StatefulWidget {
  @override
  _ReadingItemState createState() => _ReadingItemState();
}

class _ReadingItemState extends State<ReadingItem> {
  String today;

  @override
  void initState() {
    today = DateFormat('dd MMM yyyy').format(DateTime.now());
    super.initState();
  }

  Widget _buildItem(BuildContext context, AppColorTheme colorTheme) {
    return Container(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: ClipPath(
            clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
              borderRadius: AppTheme.borderRadius2,
            )),
            child: Container(
                width: MediaQuery.of(context).size.width,
                // height: 150,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: colorTheme.lightColor.withOpacity(0.8),
                    border: Border(
                      left: BorderSide(
                          width: 10.0, color: colorTheme.darkColor, style: BorderStyle.solid),
                    )),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Mazmur 14: 1 - 14',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, color: colorTheme.darkColor)),
                            SizedBox(height: 6),
                            Text(
                              'You have completed 6 readings this week',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.deactivatedText,
                                  fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                        decoration: BoxDecoration(
                          color: colorTheme.darkColor,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.arrowRight,
                          color: AppTheme.white,
                        ),
                      ),
                    ]))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 24, right: 24),
        // color: AppTheme.lightGrey,
        // height: 360,
        child: Column(children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
            FaIcon(FontAwesomeIcons.angleLeft),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(today,
                    style: TextStyle(
                        color: AppTheme.darkGrey, fontSize: 16, fontWeight: FontWeight.w600))),
            FaIcon(FontAwesomeIcons.angleRight),
          ]),
          SizedBox(height: 20),
          Column(children: <Widget>[
            _buildItem(context,
                new AppColorTheme(darkColor: AppTheme.darkGreen, lightColor: AppTheme.lightGreen)),
            _buildItem(context,
                new AppColorTheme(darkColor: AppTheme.blueText, lightColor: AppTheme.cyan)),
            _buildItem(context,
                new AppColorTheme(darkColor: AppTheme.redText, lightColor: AppTheme.lightOrange)),
            _buildItem(context,
                new AppColorTheme(darkColor: AppTheme.purpleText, lightColor: AppTheme.yellowText)),
          ]),
        ]));
  }
}
