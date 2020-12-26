// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("app_settings");
  // await Firebase.initializeApp();
  // lock portrait orientation
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(BibleStudy()));
}
