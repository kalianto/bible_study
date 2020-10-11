// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:bible_study/App.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("app_settings");
  // await Firebase.initializeApp();
  runApp(BibleStudy());
}
