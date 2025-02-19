class BibleView {
  final int id;
  final String bookName;
  final int bookNum;
  final int bookChapter;
  final int bookVerse;
  final String bibleVersion;
  final String bibleCode;
  final String bookText;
  final int bibleVersionId;

  BibleView({
    required this.id,
    required this.bookName,
    required this.bookNum,
    required this.bookChapter,
    required this.bookVerse,
    required this.bibleVersion,
    required this.bibleCode,
    required this.bookText,
    required this.bibleVersionId,
  });

  factory BibleView.fromMapEntry(Map<String, dynamic> map) {
    return BibleView(
      id: map['id'],
      bookName: map['bookName'],
      bookNum: map['bookNum'],
      bookChapter: map['bookChapter'],
      bookVerse: map['bookVerse'],
      bibleVersion: map['bibleVersion'],
      bibleCode: map['bibleCode'],
      bookText: map['bookText'],
      bibleVersionId: map['bibleVersionId'],
    );
  }
}
