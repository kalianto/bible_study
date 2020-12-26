// import 'dart:ui';
import 'package:flutter/material.dart';
import '../../app_theme.dart';

class DailyReading extends StatefulWidget {
  DailyReading({Key key, this.scrollController, this.animationController}) : super(key: key);

  final ScrollController scrollController;
  final AnimationController animationController;

  @override
  _DailyReadingState createState() => _DailyReadingState();
}

class _DailyReadingState extends State<DailyReading> {
  List<Widget> listViews = <Widget>[];

  @override
  void initState() {
    listViews.add(readingItem(1));
    listViews.add(SizedBox(height: 20));
    listViews.add(readingItem(2));
    listViews.add(SizedBox(height: 20));
    listViews.add(readingItem(3));
    listViews.add(SizedBox(height: 20));
    listViews.add(readingItem(4));
    listViews.add(SizedBox(height: 20));
    listViews.add(readingItem(5));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> getData() async {
    /// get today reading material

    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return buildListItem();
  }

  Widget buildListItem() {
    return FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return Container(
              padding: const EdgeInsets.only(top: 60, left: 14, right: 14),
              child: ListView.builder(
                controller: widget.scrollController,
                scrollDirection: Axis.vertical,
                itemCount: listViews.length,
                itemBuilder: (BuildContext context, int index) {
                  // widget.animationController.forward();
                  return listViews[index];
                },
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
              ),
            );
          }
        });
  }

  Widget readingItem(int index) {
    return Container(
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
            color: AppTheme.grey.withOpacity(0.2),
            offset: Offset(2, 2),
            blurRadius: 2.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Padding(
              // padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
              padding: const EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  //boxRowContainer(),
                  //SizedBox(height: 8),
                  boxRow(index),
                  SizedBox(height: 8),
                  // boxRowContainer(),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget boxRowContainer() {
    return Container(
      color: AppTheme.grey.withOpacity(0.1),
      child: Row(
        children: <Widget>[
          // Container(
          //   height: 48,
          //   width: 2,
          //   decoration: BoxDecoration(
          //     color: AppTheme.mandarin,
          //     borderRadius: BorderRadius.all(Radius.circular(4.0)),
          //   ),
          // ),
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
    );
  }

  Widget boxRow(int index) {
    return Row(
      children: <Widget>[
        /// Left border orange color
        Container(
          height: 48,
          width: 2,
          decoration: BoxDecoration(
            color: AppTheme.green,
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
                  'Burned $index',
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
                      'Just A Text $index',
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
    );
  }
}
