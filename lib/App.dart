import 'package:flutter/material.dart';
import 'package:bible_study/Router.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:bible_study/AppTheme.dart';

class BibleStudy extends StatelessWidget {
  // root of BibleStudy application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
