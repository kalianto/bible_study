String parseText(String text) {
  return text.replaceAll(new RegExp(r"\\"), "");
}

/// eg. id = 66011021
/// return is [21, 11, 66]
List<int> splitVerse(int verse) {
  String verses = verse.toString();
  List<int> verseList = [];

  /// verse number
  verseList.add(int.parse(verses.substring(verses.length - 3)));

  /// chapter number
  verseList.add(int.parse(verses.substring(verses.length - 6, verses.length - 3)));

  /// book number
  verseList.add(int.parse(verses.substring(0, verses.length - 6)));

  /// [verseNum, chapterNum, bookNum]
  return verseList;
}

int formatBibleId(int book, int chapter, int verse) {
  return int.parse(
      book.toString() + chapter.toString().padLeft(3, '0') + verse.toString().padLeft(3, '0'));
}

int formatBookChapter(int book, int chapter) {
  return int.parse(book.toString() + chapter.toString().padLeft(3, '0'));
}
