import 'package:flutter/material.dart';

import '../../app_theme.dart';
import '../../common/child_page_appbar.dart';
import '../../helpers/date_helper.dart' as DateHelper;
import '../../modules/rhema.dart' as RhemaModule;
import 'summary.dart';

class RhemaPage extends StatefulWidget {
  @override
  _RhemaPageState createState() => _RhemaPageState();
}

class _RhemaPageState extends State<RhemaPage> {
  DateTime today;

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    // final yesterday = today.subtract(const Duration(days: 1));
    setToday(today);
  }

  void setToday(DateTime newDate) {
    setState(() {
      today = newDate;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Stack(
          children: <Widget>[
            ChildPageAppBar(title: 'RHEMA'),
            // buildRhemaHeader(context),
            // SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
              child: buildRhemaContent(context),
            ),
          ],
        )),
      ),
    );
  }

  Widget buildRhemaHeader(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Text('Today',
                  style: TextStyle(
                      color: AppTheme.darkGrey, fontSize: 20, fontWeight: FontWeight.w500)),
              Text(DateHelper.formatDate(today, 'dd MMM y'),
                  style: TextStyle(
                      color: AppTheme.blueText, fontSize: 14, fontWeight: FontWeight.w500)),
            ]));
  }

  Widget buildRhemaContent(BuildContext context) {
    return FutureBuilder(
        future: RhemaModule.getAllRhemaSummary(),
        builder: (context, snapshot) {
          if (ConnectionState.active != null && !snapshot.hasData) {
            return Center(
                child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                CircularProgressIndicator(),
                SizedBox(height: 40),
                Text('Loading Today Rhema ...'),
              ],
            ));
          }

          if (ConnectionState.done != null && snapshot.hasError) {
            return Center(
                child: Container(
              padding: const EdgeInsets.all(15),
              decoration: AppTheme.errorBox,
              child: Text('An Error has happened when retrieving Today\'s Rhema'),
            ));
          }

          if (ConnectionState.done != null && snapshot.data.length == 0) {
            return Row(children: <Widget>[
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(20),
                      // decoration: BoxDecoration(
                      //   color: AppTheme.redText.withOpacity(0.2),
                      //   borderRadius: AppTheme.borderRadius,
                      // ),
                      child: Column(children: <Widget>[
                        Text('No Rhema item found for',
                            textAlign: TextAlign.center, style: AppTheme.subtitle1),
                        SizedBox(height: 10),
                        Text(DateHelper.formatDate(today), style: AppTheme.headline6),
                      ])))
            ]);
          }

          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Container(
                child: Column(children: <Widget>[
                  Container(
                      padding: const EdgeInsets.all(0),
                      decoration: AppTheme.boxShadowless,
                      child: Column(children: <Widget>[
                        Container(
                            padding: const EdgeInsets.all(0),
                            decoration: AppTheme.boxShadowless,
                            child: Column(children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(width: 2.0, color: AppTheme.notWhite),
                                  ),
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            DateHelper.formatDate(
                                                DateTime.parse(snapshot.data[index].summaryDate),
                                                'dd MMM yyyy'),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.15,
                                              color: AppTheme.blueText,
                                            ),
                                          )),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: InkWell(
                                                onTap: () {
                                                  // RhemaModule.deleteRhema(snapshot.data[index].id);
                                                  // setState(() {
                                                  //   snapshot.data.removeAt(index);
                                                  // });
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.only(right: 20),
                                                  child: Icon(
                                                    Icons.share,
                                                    color: AppTheme.nearlyBlack,
                                                  ),
                                                )),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: InkWell(
                                              onTap: () {
                                                RhemaModule.deleteRhema(snapshot.data[index].rhemas)
                                                    .then((_) {
                                                  setState(() {
                                                    snapshot.data.removeAt(index);
                                                  });
                                                });
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: AppTheme.mandarin,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ]),
                              ),
                              RhemaSummaryPage(data: snapshot.data[index], dataIndex: index),
                            ]))
                      ])),
                  SizedBox(
                    height: 20,
                  )
                ]),
              );
            },
          );
        });
  }
}
