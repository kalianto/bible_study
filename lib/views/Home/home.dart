import 'dart:ui';
import 'package:bible_study/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:bible_study/views/Home/daily_reading.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildPage(context),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top + 32,
          bottom: 62 + MediaQuery.of(context).padding.bottom,
        ),
        child: Wrap(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
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
                  Container(width: 20.0),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Phoebe Mockingbird',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.nearlyBlack,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        '0430111111',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.lightText,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ],
        ));
  }
}
