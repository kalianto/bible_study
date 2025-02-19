import '../models/bible_view.dart';

class AddRhemaArguments {
  AddRhemaArguments({required this.date, required this.summary, required this.rhemaVerses});

  final DateTime date;
  final String summary;
  final List<BibleView> rhemaVerses;
}
