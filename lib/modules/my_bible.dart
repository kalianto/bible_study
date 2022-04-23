import '../providers/my_bible.dart';

Future<MyBibleProvider> loadMyBible() async {
  MyBibleProvider myBibleVersion = new MyBibleProvider();
  await myBibleVersion.getMyBibleVersion();
  await myBibleVersion.getMyBibleLastVerse();
  return myBibleVersion;
}
