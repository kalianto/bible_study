import 'package:flutter/material.dart';
import 'package:gema/app_theme.dart';

import '../../models/rhema.dart';

class RhemaSummaryPage extends StatefulWidget {
  const RhemaSummaryPage({Key key, this.data, this.dataIndex}) : super(key: key);

  final RhemaSummary data;
  final int dataIndex;

  @override
  State<RhemaSummaryPage> createState() => _RhemaSummaryPageState();
}

class _RhemaSummaryPageState extends State<RhemaSummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: _buildRhemaSummary(context, widget.data, widget.dataIndex),
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
                title: Text(rhema.bibleVersesHeader),
              );
            },
            body: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 0),
              child: Column(
                children: <Widget>[
                  Text(rhema.bibleVerses),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: AppTheme.boxShadowless,
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'RHEMA',
                            style: AppTheme.headline7,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(rhema.rhemaText),
                        ),
                      ],
                    ),
                  )
                ],
              ),
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
