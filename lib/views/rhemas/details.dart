import 'package:flutter/material.dart';
import 'package:gema/app_theme.dart';

import '../../models/rhema.dart';

class RhemaDetailsPage extends StatefulWidget {
  const RhemaDetailsPage({Key key, this.data, this.dataIndex}) : super(key: key);

  final RhemaSummary data;
  final int dataIndex;

  @override
  State<RhemaDetailsPage> createState() => _RhemaSummaryPageState();
}

class _RhemaSummaryPageState extends State<RhemaDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: _buildRhemaSummary2(context, widget.data, widget.dataIndex),
    );
  }

  Widget _buildRhemaSummary2(BuildContext context, RhemaSummary data, int idx) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: data.rhemas.length,
      itemBuilder: (context, index) {
        Rhema rhema = data.rhemas[index];
        return Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 0),
            child: Column(children: <Widget>[
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  color: AppTheme.lightGreen.withOpacity(0.5),
                ),
                child: Column(children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        rhema.bibleVersesHeader,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.15,
                          color: AppTheme.nearlyBlack,
                        ),
                      )),
                  Text(rhema.bibleVerses),
                  Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'RHEMA',
                          style: AppTheme.headline7,
                        )),
                  ),
                  Align(alignment: Alignment.centerLeft, child: Text(rhema.rhemaText)),
                ]),
              )
            ]));
      },
    );
  }

  Widget _buildRhemaSummary(BuildContext context, RhemaSummary data, int idx) {
    if (data.rhemas.length > 0) {
      return ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            data.rhemas[index].isExpanded = !isExpanded;
          });
        },
        children: data.rhemas.map<ExpansionPanel>((rhema) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(rhema.bibleVersesHeader,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.15,
                      color: AppTheme.nearlyBlack,
                    )),
              );
            },
            body: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 0),
              child: Column(children: <Widget>[
                Text(rhema.bibleVerses),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: AppTheme.borderRadius,
                    color: AppTheme.mandarin.withOpacity(0.5),
                  ),
                  child: Column(children: <Widget>[
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'RHEMA',
                          style: AppTheme.headline7,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Align(alignment: Alignment.centerLeft, child: Text(rhema.rhemaText)),
                  ]),
                )
              ]),
            ),
            isExpanded: rhema.isExpanded,
          );
        }).toList(),
      );
    } else {
      return Container();
    }
  }
}
