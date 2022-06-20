class Rhema {
  final int id;
  final String rhemaDate;
  final String rhemaText;
  final int bibleVersionId;
  final List<RhemaVerse> rhemaVerses;

  Rhema({this.id, this.rhemaDate, this.rhemaText, this.bibleVersionId, this.rhemaVerses});

  factory Rhema.fromMapEntry(Map item) {
    return Rhema(
      id: item["id"],
      rhemaDate: item["rhemaDate"],
      rhemaText: item["rhemaText"],
      bibleVersionId: item["bibleVersionId"],
      // rhemaVerses: item["rhemaVerses"],
    );
  }
}

class RhemaVerse {
  final int rhemaId;
  final int verseId;
  final int verseOrder;

  RhemaVerse({this.rhemaId, this.verseId, this.verseOrder});
}
