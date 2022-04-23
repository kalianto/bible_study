import 'package:flutter/material.dart';

import '../../app_theme.dart';
import '../../models/bible_version.dart';
import '../../providers/my_bible.dart';
import '../../services/bible_version.dart';

class BibleVersionDialog extends StatelessWidget {
  BibleVersionDialog({Key key, this.myBible}) : super(key: key);

  final MyBibleProvider myBible;

  @override
  Widget build(BuildContext context) {
    //return buildBibleVersion(context, data, myBible);
    return FutureBuilder(
        future: getBibleVersion(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (ConnectionState.active != null && !snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return buildBibleVersion(context, snapshot.data, myBible);
        });
  }

  Widget buildBibleVersion(BuildContext context, data, myBible) {
    return InkWell(
        onTap: () {
          _showBibleVersionDialog(context, data, myBible);
        },
        child: Chip(
            backgroundColor: AppTheme.blueText.withOpacity(0.8),
            label: Text(
              data.firstWhere((item) => item.id == myBible.version)?.abbreviation,
              style: TextStyle(color: AppTheme.nearlyWhite, fontWeight: FontWeight.w600),
            )));
  }

  _showBibleVersionDialog(BuildContext context, List<BibleVersion> data, MyBibleProvider myBible) {
    SimpleDialog dialog = SimpleDialog(
      title: const Text('Select Bible Version'),
      children: _generateBibleVersionDialogItem(context, data),
    );

    Future futureValue = showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });

    /// From _generateBibleVersionDialogItem() onPressed()
    futureValue.then((bibleVersion) async {
      if (bibleVersion != null) {
        await myBible.saveMyBibleVersion(bibleVersion);
      }
    });
  }

  List<SimpleDialogOption> _generateBibleVersionDialogItem(
      BuildContext context, List<BibleVersion> data) {
    return List.generate(
        data.length,
        (i) => SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, data[i].id);
              },
              child: Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    child: Text(data[i].abbreviation),
                  ),
                  Padding(padding: const EdgeInsets.all(10), child: Text(data[i].version)),
                ],
              ),
            ));
  }
}

Future<List<BibleVersion>> getBibleVersion() async {
  var dbClient = BibleVersionService();
  List<BibleVersion> bibleVersionList = await dbClient.getAllBibleVersion();
  return bibleVersionList;
}
