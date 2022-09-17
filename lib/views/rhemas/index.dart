import 'package:flutter/material.dart';

import '../../app_theme.dart';
import '../../common/child_page_appbar.dart';
import '../../helpers/date_helper.dart' as DateHelper;
import '../../modules/rhema.dart' as RhemaModule;
import 'details.dart';

class RhemaPage extends StatefulWidget {
  @override
  _RhemaPageState createState() => _RhemaPageState();
}

class _RhemaPageState extends State<RhemaPage> {
  DateTime rhemaDate;

  @override
  void initState() {
    super.initState();
    final rhemaDate = DateTime.now();
    // final yesterday = rhemaDate.subtract(const Duration(days: 1));
    setRhemaDate(rhemaDate);
  }

  void setRhemaDate(DateTime newDate) {
    setState(() {
      rhemaDate = newDate;
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
            body: Container(
      decoration: AppTheme.boxDecoration,
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
      ),
    )));
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
              Text(DateHelper.formatDate(rhemaDate, 'dd MMM y'),
                  style: TextStyle(
                      color: AppTheme.blueText, fontSize: 14, fontWeight: FontWeight.w500)),
            ]));
  }

  Widget buildRhemaContent(BuildContext context) {
    return FutureBuilder(
        future: RhemaModule.getRhemaByDate(rhemaDate), // RhemaModule.getAllRhemaSummary(),
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
                        Text(DateHelper.formatDate(rhemaDate), style: AppTheme.headline6),
                        SizedBox(height: 20),
                        TextButton(
                          child: Text('Pick another date',
                              style: TextStyle(
                                  color: AppTheme.blueText,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600)),
                          onPressed: () => pickDate(context),
                        )
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
                      // decoration: AppTheme.boxShadowless,
                      child: Column(children: <Widget>[
                        Container(
                            padding: const EdgeInsets.all(0),
                            // decoration: AppTheme.boxShadowless,
                            child: Column(children: <Widget>[
                              Container(
                                // color: AppTheme.nearlyDarkBlue.withOpacity(0.3),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  // border: Border(
                                  //   bottom: BorderSide(width: 2.0, color: AppTheme.notWhite),
                                  // ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                  ),
                                  color: AppTheme.nearlyDarkBlue.withOpacity(0.3),
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextButton(
                                              onPressed: () => pickDate(context),
                                              child: Text(
                                                DateHelper.formatDate(
                                                    DateTime.parse(
                                                        snapshot.data[index].summaryDate),
                                                    'dd MMM yyyy'),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0.15,
                                                  color: AppTheme.purple,
                                                ),
                                              ))),
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
                                                    Icons.copy,
                                                    color: AppTheme.nearlyBlack,
                                                  ),
                                                )),
                                          ),
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
                                              onTap: () async {
                                                showDeleteConfirmation(context).then((answer) {
                                                  print(answer);
                                                  if (answer) {
                                                    RhemaModule.deleteRhema(
                                                            snapshot.data[index].rhemas)
                                                        .then((_) {
                                                      setState(() {
                                                        snapshot.data.removeAt(index);
                                                      });
                                                    });
                                                  }
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
                              SizedBox(height: 10),
                              RhemaDetailsPage(data: snapshot.data[index], dataIndex: index),
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

  Future<bool> showDeleteConfirmation(BuildContext context) async {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
              child: AlertDialog(
            title: Text('Delete Rhema'),
            content: Text('Are you sure you want to delete this rhema?'),
            actions: <Widget>[
              TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop(true);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: AppTheme.darkGreen,
                  ),
                  child: Text('Yes', style: TextStyle(color: AppTheme.white))),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: AppTheme.redText,
                  ),
                  child: Text('No', style: TextStyle(color: AppTheme.white)))
            ],
          ));
        });
  }

  void pickDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: rhemaDate,
      firstDate: rhemaDate.subtract(const Duration(days: 365)),
      lastDate: rhemaDate.add(const Duration(days: 365)),
    );
    if (picked != null && picked != rhemaDate) {
      setState(() {
        rhemaDate = picked;
        setRhemaDate(rhemaDate);
      });
    }
  }
}
