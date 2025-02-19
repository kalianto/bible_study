class BiblePageItemEntry {
  final int book;
  final int chapter;
  final int verseStart;
  final int verseEnd;

  BiblePageItemEntry({
    required this.book,
    required this.chapter,
    required this.verseStart,
    required this.verseEnd,
  });
}

class BiblePageItem {
  final BiblePageItemEntry current;
  final BiblePageItemEntry previous;
  final BiblePageItemEntry next;

  BiblePageItem({
    required this.current,
    required this.previous,
    required this.next,
  });
}
