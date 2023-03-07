import '../../helpers/secure_storage.dart';
import '../../models/profile.dart';

Future<Map<String, dynamic>> loadProfile() async {
  final secureStorage = SecureStorage();

  Profile profile = await secureStorage.getProfile();
  bool isLoggedIn = await secureStorage.getIsLoggedIn();
  Map<String, dynamic> map = new Map<String, dynamic>();
  map['profile'] = profile;
  map['isLoggedIn'] = isLoggedIn;
  return map;
}
