class DailyReading {
  final int dateId;
  final int sId;
  final String sBookName;
  final int sBookNum;
  final int sChapter;
  final int sVerse;
  final String sVerseSummary;
  final int eId;
  final String eBookName;
  final int eBookNum;
  final int eChapter;
  final int eVerse;
  final int groupId;
  final int orderBy;
  final String bibleVersion;
  final String bibleCode;
  final int id;
  final DateTime fullDate;
  final int sVerseEnd;

  DailyReading({
    required this.dateId,
    required this.sId,
    required this.sBookName,
    required this.sBookNum,
    required this.sChapter,
    required this.sVerse,
    required this.sVerseSummary,
    required this.eId,
    required this.eBookName,
    required this.eBookNum,
    required this.eChapter,
    required this.eVerse,
    required this.groupId,
    required this.orderBy,
    required this.bibleVersion,
    required this.bibleCode,
    required this.id,
    required this.fullDate,
    required this.sVerseEnd,
  });

  String shortSummary() {
    String startTitle = this.sBookName + ' ' + this.sChapter.toString() + ':' + this.sVerse.toString();
    String endTitle = ' - ';
    // cross book
    if (this.eBookNum != this.sBookNum) {
      endTitle += this.eBookName + ' ' + this.eChapter.toString() + ':' + this.eVerse.toString();
    } else {
      // same book same chapter
      if (this.eChapter == this.sChapter) {
        endTitle += this.eVerse.toString();
      } else {
        endTitle += this.eChapter.toString() + ':' + this.eVerse.toString();
      }
    }

    return startTitle + endTitle;
  }

  String gridSummary() {
    String summary = '';

    // cross book
    if (this.eBookNum != this.sBookNum) {
      summary = '${this.sBookName} \n${this.sChapter.toString()}';
      summary += '\n\n${this.eBookName} \n${this.eChapter.toString()}';
    } else {
      // same book same chapter
      if (this.eChapter == this.sChapter) {
        summary = '${this.sBookName} \n\n';
        summary += '${this.sChapter.toString()}:${this.sVerse.toString()}';
        summary += ' - ${this.eVerse.toString()}';
      } else {
        summary = '${this.sBookName} \n\n';
        summary += '${this.sChapter.toString()}:${this.sVerse.toString()}';
        summary += ' - ${this.eChapter.toString()}:${this.eVerse.toString()}';
      }
    }

    return summary;
  }

  String firstVerse() {
    return this.sVerseSummary;
  }
}
