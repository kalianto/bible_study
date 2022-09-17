import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../app_theme.dart';
import '../../helpers/date_helper.dart' as DateHelper;
import '../../models/daily_reading.dart';
import '../../models/daily_reading_arguments.dart';
import '../../modules/daily_reading.dart' as DailyReadingModule;
import '../../providers/my_bible.dart';

class DailyReadingItem extends StatelessWidget {
  DailyReadingItem({
    Key key,
    this.date,
    this.myBible,
  }) : super(key: key);

  final DateTime date;
  final MyBibleProvider myBible;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 18),
      child: Column(children: <Widget>[
        _buildReadingItemSummary(context, date, myBible.version),
        SizedBox(height: 20),
      ]),
    );
  }

  Widget _buildReadingItemSummary(BuildContext context, DateTime date, int bibleVersionIndex) {
    return FutureBuilder(
        future: DailyReadingModule.getDailyReadingSummary(date, bibleVersionIndex),
        builder: (context, snapshot) {
          if (ConnectionState.active != null && !snapshot.hasData) {
            return Center(
                child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                CircularProgressIndicator(),
                SizedBox(height: 40),
                Text('Loading Daily Reading ...'),
              ],
            ));
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
                        Text(DateHelper.formatDate(date), style: AppTheme.headline6),
                      ])))
            ]);
          }

          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return _buildItemBox(
                  context,
                  new AppColorTheme(
                      darkColor: AppTheme.colorSet2[index]['darkColor'],
                      lightColor: AppTheme.colorSet2[index]['lightColor']),
                  snapshot.data,
                  index);
            },
          );
        });
  }

  // Widget _buildItem(BuildContext context, AppColorTheme colorTheme, DailyReading item) {
  //   return Container(
  //       // padding: const EdgeInsets.only(bottom: 12.0),
  //       child: InkWell(
  //           onTap: () async {
  //             /// BibleReading IconButton.onPressed return BibleVersion that will be captured here
  //             /// File: bible_reading_bar.dart
  //             /// However, after implementing Provider in bible_reading_bar, this never gets called
  //             /// anymore. i am wondering why????
  //             DailyReadingArguments arguments =
  //                 new DailyReadingArguments(index: 1, item: item, date: date);
  //             final result =
  //                 await Navigator.pushNamed(context, '/daily-reading', arguments: arguments);
  //
  //             /// result is not null when user changes bible version
  //             if (result != null) {
  //               myBible.saveMyBibleVersion(result);
  //             }
  //           },
  //           child: Container(
  //               width: MediaQuery.of(context).size.width,
  //               // height: 150,
  //               padding: const EdgeInsets.only(top: 15, bottom: 15, left: 0, right: 0),
  //               decoration: BoxDecoration(
  //                   //color: colorTheme.lightColor.withOpacity(0.8),
  //                   border: Border(
  //                 bottom: BorderSide(
  //                     width: 1.0, color: colorTheme.lightColor, style: BorderStyle.solid),
  //               )),
  //               child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: <Widget>[
  //                     Expanded(
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: <Widget>[
  //                           SizedBox(height: 4),
  //                           Text(item.shortSummary(),
  //                               style: TextStyle(
  //                                   fontWeight: FontWeight.w500,
  //                                   color: colorTheme.darkColor,
  //                                   fontSize: 18)),
  //                           SizedBox(height: 8),
  //                           Text(
  //                             item.firstVerse(),
  //                             overflow: TextOverflow.ellipsis,
  //                             style: TextStyle(
  //                                 fontWeight: FontWeight.w400,
  //                                 color: AppTheme.deactivatedText,
  //                                 fontSize: 12),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                     Container(
  //                       padding: const EdgeInsets.all(0),
  //                       child: IconButton(
  //                         padding: const EdgeInsets.all(0),
  //                         icon: FaIcon(
  //                           // FontAwesomeIcons.solidCheckCircle,
  //                           FontAwesomeIcons.playCircle,
  //                           color: colorTheme.darkColor,
  //                         ),
  //                         onPressed: () {
  //                           DailyReadingArguments arguments =
  //                               new DailyReadingArguments(index: 1, item: item, date: date);
  //                           Navigator.pushNamed(context, '/daily-reading', arguments: arguments);
  //                         },
  //                         splashColor: colorTheme.darkColor,
  //                       ),
  //                     ),
  //                   ]))));
  // }

  Widget _buildItemBox(
      BuildContext context, AppColorTheme colorTheme, List<DailyReading> items, int index) {
    return Container(
        // padding: const EdgeInsets.only(bottom: 12.0),
        child: InkWell(
            onTap: () async {
              /// BibleReading IconButton.onPressed return BibleVersion that will be captured here
              /// File: bible_reading_bar.dart
              /// However, after implementing Provider in bible_reading_bar, this never gets called
              /// anymore. i am wondering why????
              DailyReadingArguments arguments = new DailyReadingArguments(
                  index: index, item: items[index], date: date, itemList: items);
              final result =
                  await Navigator.of(context).pushNamed('/daily-reading', arguments: arguments);

              /// result is not null when user changes bible version
              if (result != null) {
                myBible.saveMyBibleVersion(result);
              }
            },
            child: Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  padding: const EdgeInsets.only(top: 15, left: 20, right: 5, bottom: 15),
                  decoration: BoxDecoration(
                    color: AppTheme.lightGrey.withOpacity(0.3),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      bottomLeft: Radius.circular(4.0),
                      bottomRight: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(items[index].shortSummary(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.darkGrey,
                                    fontSize: 18)),
                            SizedBox(height: 6),
                            Text(
                              items[index].firstVerse(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.deactivatedText,
                                  fontSize: 13),
                            )
                          ],
                        ),
                      ),
                      Container(
                        // padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                        child: IconButton(
                          padding: const EdgeInsets.all(0),
                          icon: FaIcon(
                            FontAwesomeIcons.playCircle,
                            color: colorTheme.darkColor,
                          ),
                          onPressed: () {
                            DailyReadingArguments arguments = new DailyReadingArguments(
                                index: index, item: items[index], date: date, itemList: items);
                            Navigator.of(context).pushNamed('/daily-reading', arguments: arguments);
                          },
                          splashColor: colorTheme.darkColor,
                        ),
                      )
                    ],
                  ),
                ))));
  }
}
