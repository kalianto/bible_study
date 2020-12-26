import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../app_theme.dart';
import '../../common/child_page_appbar.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: <Widget>[
          ChildPageAppBar(title: 'Profile'),
          profileHome(context),
          // SizedBox(
          //   height: MediaQuery.of(context).padding.bottom,
          // )
        ],
      )),
    );
  }

  Widget profileHome(BuildContext context) {
    return Container(
        child: Wrap(
      children: <Widget>[
        Container(
          child: new Container(
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    bottomLeft: Radius.circular(4.0),
                    bottomRight: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: AppTheme.grey.withOpacity(0.6),
                      offset: Offset(0.2, 0.2),
                      blurRadius: 2.0,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: AppTheme.grey.withOpacity(0.6),
                            offset: const Offset(2.0, 4.0),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                        child: Image.asset('assets/images/userImage.png'),
                      ),
                    ),
                    Container(width: 15.0),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Maggie ',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.nearlyBlack,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          '0430111111',
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            color: AppTheme.darkerText,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0, bottom: 24, left: 24, right: 24),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6.0),
                bottomLeft: Radius.circular(6.0),
                bottomRight: Radius.circular(6.0),
                topRight: Radius.circular(6.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: AppTheme.grey.withOpacity(0.4),
                  offset: Offset(2, 2),
                  blurRadius: 2.0,
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                        // padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 48,
                                  width: 2,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF87A0E5).withOpacity(0.5),
                                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4, bottom: 2),
                                        child: Text(
                                          'Eaten',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            letterSpacing: -0.1,
                                            color: AppTheme.grey.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: <Widget>[
                                          SizedBox(width: 28, height: 28, child: Icon(Icons.message)),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 4, bottom: 3),
                                            child: Text(
                                              'Another Text',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: AppTheme.fontName,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: AppTheme.darkerText,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 4, bottom: 3),
                                            child: Text(
                                              'Kcal',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: AppTheme.fontName,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                letterSpacing: -0.2,
                                                color: AppTheme.grey.withOpacity(0.5),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 48,
                                  width: 2,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF56E98).withOpacity(0.5),
                                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4, bottom: 2),
                                        child: Text(
                                          'Burned',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            letterSpacing: -0.1,
                                            color: AppTheme.grey.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 28,
                                            height: 28,
                                            child: Icon(Icons.dashboard),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 4, bottom: 3),
                                            child: Text(
                                              'Just A Text',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: AppTheme.fontName,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: AppTheme.darkerText,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8, bottom: 3),
                                            child: Text(
                                              'Kcal',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: AppTheme.fontName,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                letterSpacing: -0.2,
                                                color: AppTheme.grey.withOpacity(0.5),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0, bottom: 24, left: 24, right: 24),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 12),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    // padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              height: 48,
                              width: 2,
                              decoration: BoxDecoration(
                                color: Color(0xFF87A0E5).withOpacity(0.5),
                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4, bottom: 2),
                                    child: Text(
                                      'Eaten',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: AppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.1,
                                        color: AppTheme.grey.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      SizedBox(width: 28, height: 28, child: Icon(Icons.message)),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4, bottom: 3),
                                        child: Text(
                                          'Another Text',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: AppTheme.darkerText,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4, bottom: 3),
                                        child: Text(
                                          'Kcal',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            letterSpacing: -0.2,
                                            color: AppTheme.grey.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              height: 48,
                              width: 2,
                              decoration: BoxDecoration(
                                color: Color(0xFFF56E98).withOpacity(0.5),
                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4, bottom: 2),
                                    child: Text(
                                      'Burned',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: AppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.1,
                                        color: AppTheme.grey.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 28,
                                        height: 28,
                                        child: Icon(Icons.dashboard),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4, bottom: 3),
                                        child: Text(
                                          'Just A Text',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: AppTheme.darkerText,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8, bottom: 3),
                                        child: Text(
                                          'Kcal',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            letterSpacing: -0.2,
                                            color: AppTheme.grey.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
