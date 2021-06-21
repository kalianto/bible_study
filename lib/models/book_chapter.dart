class BookChapter {
  final int bookId;
  final int chapterStart;
  final int chapterEnd;
  final String bookName;
  final List<int> chapters;

  BookChapter({
    this.bookId,
    this.chapterStart, 
    this.chapterEnd,
    this.bookName,
    this.chapters,
  });

  factory BookChapter.fromMapEntry(Map item) {
    return BookChapter(
      bookId: item["bookId"],
      chapterStart: item["chapterStart"],
      chapterEnd: item["chapterEnd"],
      bookName: item['bookName'],
      chapters: List<int>.generate(item["chapterEnd"], (i) => i + 1),
    );
  }
}
