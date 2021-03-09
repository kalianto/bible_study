import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../app_theme.dart';

class ReadingItem extends StatefulWidget {
  @override
  _ReadingItemState createState() => _ReadingItemState();
}

class _ReadingItemState extends State<ReadingItem> {
  DateTime today;

  @override
  void initState() {
    super.initState();
    today = new DateTime.now();
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
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
                                    fontWeight: FontWeight.w500,
                                    color: colorTheme.darkColor,
                                    fontSize: 16)),
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
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: FaIcon(
                          // FontAwesomeIcons.solidCheckCircle,
                          FontAwesomeIcons.arrowAltCircleRight,
                          color: colorTheme.darkColor,
                        ),
                      ),
                    ]))));
  }

  void previousDay() {
    print('called previous day');
    print(today);
    setState(() {
      today = today.subtract(const Duration(days: 1));
    });
  }

  void nextDay() {
    print('called next day');
    print(today);
    setState(() {
      today = today.add(const Duration(days: 1));
    });
  }

  void pickDate(BuildContext context) async {
    print('Show calendar');
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: today,
        firstDate: today.subtract(const Duration(days: 365)),
        lastDate: today.add(const Duration(days: 365)),
    );
    if (picked != null && picked != today)
      setState(() {
        today = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 24, right: 24),
        // color: AppTheme.lightGrey,
        // height: 360,
        child: Column(children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
            IconButton(
              icon: FaIcon(FontAwesomeIcons.angleLeft),
              onPressed: previousDay,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextButton(
                child: Text(_formatDate(today),
                  style: TextStyle(
                      color: AppTheme.darkGrey, fontSize: 16, fontWeight: FontWeight.w600
                  )
                ),
                onPressed: () => pickDate(context),
              ),

            ),
            IconButton(
              icon: FaIcon(FontAwesomeIcons.angleRight),
              onPressed: nextDay,
            ),
          ]),
          SizedBox(height: 10),
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
