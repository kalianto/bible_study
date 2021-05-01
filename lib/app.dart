import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';

import 'app_theme.dart';
import 'router.dart';
import 'common/my_bible_version.dart';

class BibleStudy extends StatelessWidget {
  /// root of BibleStudy application
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return FutureProvider<MyBibleVersion>(
        initialData: MyBibleVersion(),
        create: (context) => loadMyBibleVersion(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: GlobalConfiguration().getValue('appName'),
          theme: ThemeData(
            primarySwatch: AppTheme.primarySwatch,
            primaryColor: AppTheme.primaryColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: AppTheme.fontName,
            textTheme: AppTheme.textTheme,
          ),
          initialRoute: '/',
          onGenerateRoute: BaseRouter.route,
        ));
  }
}
