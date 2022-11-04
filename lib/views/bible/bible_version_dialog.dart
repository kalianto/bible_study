import 'package:flutter/material.dart';

import '../../app_theme.dart';
import '../../models/bible_version.dart';
import '../../modules/bible_version.dart' as BibleVersionModule;
import '../../providers/my_bible.dart';

class BibleVersionDialog extends StatelessWidget {
  BibleVersionDialog({Key key, this.myBible}) : super(key: key);

  final MyBibleProvider myBible;

  @override
  Widget build(BuildContext context) {
    //return buildBibleVersion(context, data, myBible);
    return FutureBuilder(
      future: BibleVersionModule.getBibleVersion(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (ConnectionState.active != null && !snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return buildBibleVersion(context, snapshot.data, myBible);
      },
    );
  }

  Widget buildBibleVersion(BuildContext context, data, myBible) {
    return InkWell(
      onTap: () {
        _showBibleVersionDialog(context, data, myBible);
      },
      child: Container(
        padding: const EdgeInsets.only(
          top: 5,
          bottom: 5,
          left: 10,
          right: 10,
        ),
        decoration: BoxDecoration(
          color: AppTheme.darkGrey.withOpacity(0.5),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0.0),
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          // border: Border.all(
          //   color: AppTheme.lightGrey,
          // ),
        ),
        child: Text(
          data.firstWhere((item) => item.id == myBible.version)?.abbreviation,
          style: TextStyle(
            fontFamily: AppTheme.fontName,
            fontWeight: FontWeight.w400,
            fontSize: 16,
            // letterSpacing: 1.2,
            color: AppTheme.nearlyWhite,
          ),
        ),
      ),
    );
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
      },
    );

    /// From _generateBibleVersionDialogItem() onPressed()
    futureValue.then((bibleVersion) async {
      if (bibleVersion != null) {
        await myBible.saveMyBibleVersion(bibleVersion);
      }
    });
  }

  List<SimpleDialogOption> _generateBibleVersionDialogItem(BuildContext context, List<BibleVersion> data) {
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
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(data[i].version),
            ),
          ],
        ),
      ),
    );
  }
}
