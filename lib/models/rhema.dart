import '../helpers/bible_helper.dart' as BibleHelper;
import '../helpers/date_helper.dart' as DateHelper;
import 'bible_view.dart';

class Rhema {
  int id;
  DateTime rhemaDate;
  String rhemaText;
  int bibleVersionId;
  List<RhemaVerse> rhemaVerses;
  String dateKey;
  String bibleTable;
  String bibleLang;
  String bibleAbbreviation;
  String bibleVerses;
  String bibleVersesHeader;
  bool isExpanded;

  Rhema({
    required this.id,
    required this.rhemaDate,
    required this.rhemaText,
    required this.bibleVersionId,
    required this.rhemaVerses,
    required this.dateKey,
    required this.bibleTable,
    required this.bibleLang,
    required this.bibleAbbreviation,
    required this.bibleVerses,
    this.bibleVersesHeader = '',
    this.isExpanded = false,
  });

  factory Rhema.fromMapEntry(Map item) {
    return new Rhema(
      id: item["id"],
      rhemaDate: DateTime.parse(item["rhemaDate"]),
      rhemaText: item["rhemaText"],
      bibleVersionId: item["bibleVersionId"],
      dateKey: item["dateKey"],
      bibleTable: item["bibleTable"],
      bibleLang: item["bibleLang"],
      bibleAbbreviation: item["bibleAbbreviation"],
      rhemaVerses: (item["rhemaVerses"] as List).map((verse) => RhemaVerse.fromMapEntry(verse)).toList(),
      bibleVerses: item["bibleVerses"],
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'rhemaDate': DateHelper.formatDateSQLite(rhemaDate),
        'rhemaText': rhemaText,
        'bibleVersionId': bibleVersionId,
        'dateKey': DateHelper.formatDate(rhemaDate, 'yyyy-MM-dd'),
      };
}

class RhemaVerse {
  int rhemaId;
  int verseId;
  int verseOrder;
  String verse;
  BibleView bibleView;

  RhemaVerse({
    required this.rhemaId,
    required this.verseId,
    required this.verseOrder,
    required this.verse,
    required this.bibleView,
  });

  Map<String, dynamic> toMap() => {
        'rhemaId': rhemaId,
        'verseId': verseId,
        'verseOrder': verseOrder,
      };

  factory RhemaVerse.fromMapEntry(Map item) {
    return new RhemaVerse(
      rhemaId: item["rhemaId"],
      verseId: item["verseId"],
      verseOrder: item["verseOrder"],
      verse: item['verse'],
      bibleView: BibleView.fromMapEntry(item['bibleView']),
    );
  }
}

class RhemaSummary {
  String summaryDate;
  List<Rhema> rhemas;

  RhemaSummary({required this.summaryDate, required this.rhemas});

  void generateVerseSummary() {
    for (Rhema rhema in rhemas) {
      List<BibleView> bibleViewList = [];
      for (RhemaVerse rhemaVerse in rhema.rhemaVerses) {
        bibleViewList.add(rhemaVerse.bibleView);
      }
      Map<String, String> summary = BibleHelper.generateBibleVerses(bibleViewList);
      rhema.bibleVerses = summary['body'] as String;
      rhema.bibleVersesHeader = summary['header'] as String;
    }
  }
}
