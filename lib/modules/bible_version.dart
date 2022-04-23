import '../models/bible_version.dart';
import '../services/bible_version.dart';

Future<List<BibleVersion>> getBibleVersion() async {
  var dbClient = BibleVersionService();
  List<BibleVersion> bibleVersionList = await dbClient.getAllBibleVersion();
  return bibleVersionList;
}
