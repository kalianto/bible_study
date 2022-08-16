import '../models/bible_view.dart';

class AddRhemaArguments {
  AddRhemaArguments({this.date, this.summary, this.rhemaVerses});

  final DateTime date;
  final String summary;
  final List<BibleView> rhemaVerses;
}
