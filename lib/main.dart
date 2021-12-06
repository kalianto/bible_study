// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
// import 'dart:io';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("app_settings");
  // await Firebase.initializeApp();

  /** This will hide the status bar and do other things I don't know about*/
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  //   statusBarIconBrightness: Brightness.dark,
  //   statusBarBrightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
  //   systemNavigationBarColor: Colors.white,
  //   systemNavigationBarDividerColor: Colors.grey,
  //   systemNavigationBarIconBrightness: Brightness.dark,
  // ));

  // lock portrait orientation
  await SystemChrome.setPreferredOrientations(
          <DeviceOrientation>[DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(BibleStudy()));
}
