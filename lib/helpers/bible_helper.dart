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