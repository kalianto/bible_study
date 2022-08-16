import '../helpers/date_helper.dart' as DateHelper;

class Rhema {
  int id;
  DateTime rhemaDate;
  String rhemaText;
  int bibleVersionId;
  RhemaVerse rhemaVerses;
  String dateKey;

  Rhema(
      {this.id,
      this.rhemaDate,
      this.rhemaText,
      this.bibleVersionId,
      this.rhemaVerses,
      this.dateKey});

  factory Rhema.fromMapEntry(Map item) {
    return new Rhema(
      id: item["id"],
      rhemaDate: DateTime.parse(item["rhemaDate"]),
      rhemaText: item["rhemaText"],
      bibleVersionId: item["bibleVersionId"],
      dateKey: DateHelper.formatDate(DateTime.parse(item["rhemaDate"]), 'y-LL-dd'),
      rhemaVerses: new RhemaVerse(
          rhemaId: item["id"], verseId: item["verseId"], verseOrder: item['verseOrder']),
    );
  }
  Map<String, dynamic> toMap() => {
        'id': id,
        'rhemaDate': rhemaDate.toString(),
        'rhemaText': rhemaText,
        'bibleVersionId': bibleVersionId,
      };
}

class RhemaVerse {
  int rhemaId;
  int verseId;
  int verseOrder;

  RhemaVerse({this.rhemaId, this.verseId, this.verseOrder});

  Map<String, dynamic> toMap() => {
        'rhemaId': rhemaId,
        'verseId': verseId,
        'verseOrder': verseOrder,
      };
}

class RhemaSummary {
  String summaryDate;
  List<Rhema> rhemas;

  RhemaSummary({this.summaryDate, this.rhemas});

  String summary() {
    this.rhemas.forEach((rhema) {
      print(rhema);
    });
    return 'Summary';
  }
}
