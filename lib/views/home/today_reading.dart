import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../app_theme.dart';

class TodayReading extends StatefulWidget {
  final TextStyle chapterNameStyle = TextStyle(
    fontFamily: AppTheme.fontName,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppTheme.darkerText,
  );
  final TextStyle verseStyle = TextStyle(
    fontFamily: AppTheme.fontName,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    // fontStyle: FontStyle.italic,
    color: AppTheme.grey.withOpacity(0.5),
  );

  @override
  _TodayReadingState createState() => _TodayReadingState();
}

class _TodayReadingState extends State<TodayReading> {
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
                child: Text('23 Nov 2020',
                    style: TextStyle(
                        color: AppTheme.darkGrey, fontSize: 16, fontWeight: FontWeight.w600))),
            FaIcon(FontAwesomeIcons.angleRight),
          ]),
          SizedBox(height: 20),
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 2.4,
                    height: 150,
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
                    decoration: BoxDecoration(
                      color: AppTheme.lightGreen.withOpacity(0.8),
                      borderRadius: AppTheme.borderRadius2,
                      // border: Border.all(width: 2, color: AppTheme.darkGreen.withOpacity(0.5)),
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                      Text('Ayub 42', style: widget.chapterNameStyle),
                      Text('Ver 1 - 17', style: widget.verseStyle),
                      SizedBox(height: 15),
                      Text('Pengkhotbah 1', style: widget.chapterNameStyle),
                      Text('Ver 1 - 18', style: widget.verseStyle),
                      SizedBox(height: 5),
                      Align(
                        child: FaIcon(
                          FontAwesomeIcons.angleRight,
                          color: AppTheme.nearlyBlack,
                        ),
                        alignment: Alignment.centerRight,
                      )
                    ]),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width / 2.4,
                    height: 150,
                    decoration: BoxDecoration(
                      color: AppTheme.purple.withOpacity(0.2),
                      borderRadius: AppTheme.borderRadius2,
                      // border: Border.all(width: 2, color: AppTheme.purple.withOpacity(0.5)),
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                      Row(children: <Widget>[
                        Expanded(
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppTheme.purple.withOpacity(0.3),
                                  borderRadius: AppTheme.borderRadius2,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text('Ayub 42', style: widget.chapterNameStyle),
                                    Text('Ver 1 - 17', style: widget.verseStyle),
                                  ],
                                )))
                      ]),
                      SizedBox(height: 5),
                      Row(children: <Widget>[
                        Expanded(
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppTheme.purple.withOpacity(0.3),
                                  borderRadius: AppTheme.borderRadius2,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text('Pengkhotbah 1', style: widget.chapterNameStyle),
                                    Text('Ver 1 - 18', style: widget.verseStyle),
                                  ],
                                )))
                      ]),
                    ]),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width / 2.4,
                      height: 150,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppTheme.yellowText.withOpacity(0.2),
                        borderRadius: AppTheme.borderRadius2,
                        // border: Border.all(width: 2, color: AppTheme.yellowText.withOpacity(0.5)),
                      ),
                      child:
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                        Text('Yehez 42', style: widget.chapterNameStyle),
                        Text('Ver 1 - 17', style: widget.verseStyle),
                        Text('Ayub 42', style: widget.chapterNameStyle),
                        Text('Ver 1 - 17', style: widget.verseStyle),
                      ])),
                  SizedBox(height: 20),
                  Container(
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width / 2.4,
                      height: 150,
                      decoration: BoxDecoration(
                        color: AppTheme.blueText.withOpacity(0.2),
                        borderRadius: AppTheme.borderRadius2,
                        // border: Border.all(width: 2, color: AppTheme.blueText.withOpacity(0.5)),
                      ),
                      child:
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                        Text('Amsal 28:28 - 29:1', style: widget.chapterNameStyle),
                      ]))
                ],
              ),
            ],
          ))
        ]));
  }
}
