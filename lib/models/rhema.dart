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
    this.id,
    this.rhemaDate,
    this.rhemaText,
    this.bibleVersionId,
    this.rhemaVerses,
    this.dateKey,
    this.bibleTable,
    this.bibleLang,
    this.bibleAbbreviation,
    this.bibleVerses,
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
      // rhemaVerses: RhemaVerse.fromMapEntry(item),
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

  RhemaVerse({this.rhemaId, this.verseId, this.verseOrder, this.verse, this.bibleView});

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
    );
  }
}

class RhemaSummary {
  String summaryDate;
  List<Rhema> rhemas;

  RhemaSummary({this.summaryDate, this.rhemas});

  void generateVerseSummary() {
    for (Rhema rhema in rhemas) {
      List<BibleView> bibleViewList = [];
      for (RhemaVerse rhemaVerse in rhema.rhemaVerses) {
        bibleViewList.add(rhemaVerse.bibleView);
      }
      Map<String, String> summary = BibleHelper.generateBibleVerses(bibleViewList);
      rhema.bibleVerses = summary['body'];
      rhema.bibleVersesHeader = summary['header'];
    }
  }
}
