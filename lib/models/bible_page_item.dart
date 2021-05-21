class BiblePageItemEntry {
  final int book;
  final int chapter;
  final int verseStart;
  final int verseEnd;

  BiblePageItemEntry({
    this.book,
    this.chapter,
    this.verseStart,
    this.verseEnd,
  });
}

class BiblePageItem {
  final BiblePageItemEntry current;
  final BiblePageItemEntry previous;
  final BiblePageItemEntry next;

  BiblePageItem({
    this.current,
    this.previous,
    this.next,
  });
}