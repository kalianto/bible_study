import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../app_theme.dart';
import '../../models/daily_reading.dart';
import 'package:bible_study/providers/daily_reading.dart';

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

  Widget _buildItem(BuildContext context, AppColorTheme colorTheme, DailyReading item) {
    return Container(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: ClipPath(
            clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
              borderRadius: AppTheme.borderRadius2,
            )),
            child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/bible-view', arguments: item);
                },
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    // height: 150,
                    padding: const EdgeInsets.all(15),
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
                                SizedBox(height: 4),
                                Text(item.shortSummary(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: colorTheme.darkColor,
                                        fontSize: 18)),
                                SizedBox(height: 8),
                                Text(
                                  item.firstVerse(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: AppTheme.deactivatedText,
                                      fontSize: 12),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(0),
                            child: IconButton(
                              padding: const EdgeInsets.all(0),
                              icon: FaIcon(
                                // FontAwesomeIcons.solidCheckCircle,
                                FontAwesomeIcons.arrowCircleRight,
                                color: colorTheme.darkColor,
                              ),
                              // onPressed: () {
                              //   Navigator.pushNamed(context, '/bible-view', arguments: item);
                              // },
                              splashColor: colorTheme.darkColor,
                            ),
                          ),
                        ])))));
  }

  void previousDay() {
    setState(() {
      today = today.subtract(const Duration(days: 1));
    });
  }

  void nextDay() {
    setState(() {
      today = today.add(const Duration(days: 1));
    });
  }

  void pickDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: today.subtract(const Duration(days: 365)),
      lastDate: today.add(const Duration(days: 365)),
    );
    if (picked != null && picked != today) {
      setState(() {
        today = picked;
      });
    }
  }

  Future<List<DailyReading>> getDailyReadingSummary(DateTime date) async {
    var dbClient = DailyReadingProvider();
    List<DailyReading> dailyReadingList = await dbClient.getDailyReading(date);
    return dailyReadingList;
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
                        color: AppTheme.darkGrey, fontSize: 16, fontWeight: FontWeight.w600)),
                onPressed: () => pickDate(context),
              ),
            ),
            IconButton(
              icon: FaIcon(FontAwesomeIcons.angleRight),
              onPressed: nextDay,
            ),
          ]),
          SizedBox(height: 10),
          Column(children: <Widget>[_buildReadingItemSummary(context, today)]),
        ]));
  }

  Widget _buildReadingItemSummary(BuildContext context, DateTime date) {
    return FutureBuilder(
        future: getDailyReadingSummary(date),
        builder: (context, snapshot) {
          if (ConnectionState.active != null && !snapshot.hasData) {
            return Center(
                child: Column(children: <Widget>[
              SizedBox(height: 20),
              CircularProgressIndicator(),
              SizedBox(height: 40),
              Text('Loading Daily Reading ...'),
            ]));
          }

          if (ConnectionState.done != null && snapshot.hasError) {
            return Center(child: Text(snapshot.error));
          }

          if (ConnectionState.done != null && snapshot.data.length == 0) {
            return Row(children: <Widget>[
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppTheme.redText.withOpacity(0.2),
                        borderRadius: AppTheme.borderRadius,
                      ),
                      child: Column(children: <Widget>[
                        Text('Unable to load item for',
                            textAlign: TextAlign.center, style: AppTheme.subtitle1),
                        SizedBox(height: 10),
                        Text(_formatDate(today), style: AppTheme.headline6),
                      ])))
            ]);
          }

          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return _buildItem(
                  context,
                  new AppColorTheme(
                      darkColor: AppTheme.colorSet2[index]['darkColor'],
                      lightColor: AppTheme.colorSet2[index]['lightColor']),
                  snapshot.data[index]);
            },
          );
        });
  }
}
