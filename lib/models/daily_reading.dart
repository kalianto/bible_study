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

  DailyReading({this.dateId,
    this.sId,
    this.sBookName,
    this.sBookNum,
    this.sChapter,
    this.sVerse,
    this.sVerseSummary,
    this.eId,
    this.eBookName,
    this.eBookNum,
    this.eChapter,
    this.eVerse,
    this.groupId,
    this.orderBy});

  String shortSummary() {
    String startTitle = this.sBookName + ' ' + this.sChapter.toString() + ':' +
        this.sVerse.toString();
    String endTitle = ' - ';
    if (this.eBookNum != this.sBookNum) {
      endTitle += this.eBookName + ' ' + this.eChapter.toString() + ':' + this.eVerse.toString();
    } else {
      if (this.eChapter == this.sChapter) {
        endTitle += this.eVerse.toString();
      } else {
        endTitle += this.eChapter.toString() + ':' + this.eVerse.toString();
      }
    }

    return startTitle + endTitle;
  }

  String firstVerse() {
    return this.sVerseSummary;
  }
}


