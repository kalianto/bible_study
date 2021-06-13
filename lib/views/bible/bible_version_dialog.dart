import 'package:flutter/material.dart';

import '../../app_theme.dart';
import '../../models/bible_version.dart';
import '../../services/bible_version.dart';
import '../../providers/my_bible.dart';

class BibleVersionDialog extends StatelessWidget {
  BibleVersionDialog({Key key, this.data, this.myBible}) : super(key: key);

  final List<BibleVersion> data;
  final MyBible myBible;

  @override
  Widget build(BuildContext context) {
    return buildBibleVersion(context, data, myBible);
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

  _showBibleVersionDialog(BuildContext context, List<BibleVersion> data, MyBible myBible) {
    SimpleDialog dialog = SimpleDialog(
      title: const Text('Select Bible Version'),
      children: _generateBibleVersionDialogItem(context, data),
    );

    Future futureValue = showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });

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
  var dbClient = BibleVersionProvider();
  List<BibleVersion> bibleVersionList = await dbClient.getAllBibleVersion();
  return bibleVersionList;
}
