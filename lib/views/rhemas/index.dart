import 'package:flutter/material.dart';

import '../../app_theme.dart';
import '../../common/child_page_appbar.dart';
import '../../helpers/date_helper.dart' as DateHelper;
import '../../modules/rhema.dart' as RhemaModule;

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
          body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ChildPageAppBar(title: 'RHEMA'),
              // Container(
              //   padding: const EdgeInsets.only(top: 50),
              //   child: SingleChildScrollView(
              //       child: Container(
              //     padding: const EdgeInsets.all(40),
              //     child: Text('The content of this page is being constructed'),
              //   )),
              // ),
              Container(
                  padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        buildRhemaHeader(context),
                        SizedBox(height: 20),
                        buildRhemaContent(context),
                      ])),
            ],
          ),
        ),
      )),
    );
  }

  Widget buildRhemaHeader(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          Text('Today',
              style:
                  TextStyle(color: AppTheme.darkGrey, fontSize: 20, fontWeight: FontWeight.w500)),
          Text(DateHelper.formatDate(today, 'dd MMM y'),
              style:
                  TextStyle(color: AppTheme.blueText, fontSize: 14, fontWeight: FontWeight.w500)),
        ]);
  }

  Widget buildRhemaContent(BuildContext context) {
    return FutureBuilder(
        future: RhemaModule.getTodayRhema(),
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
                      decoration: BoxDecoration(
                        color: AppTheme.redText.withOpacity(0.2),
                        borderRadius: AppTheme.borderRadius,
                      ),
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
              return Column(children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: AppTheme.boxDecoration,
                  child: Text(snapshot.data[index].rhemaText),
                ),
                SizedBox(
                  height: 20,
                )
              ]);
            },
          );
        });
  }
}
