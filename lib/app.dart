// import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';

import 'app_theme.dart';
import 'modules/my_bible.dart' as MyBibleModule;
import 'providers/my_bible.dart';
import 'router.dart';

class BibleStudy extends StatelessWidget {
  /// root of BibleStudy application
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MyBibleModule.loadMyBible(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (ConnectionState.active != null && !snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ChangeNotifierProvider<MyBibleProvider>.value(
          value: snapshot.data,
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
          ),
        );
      },
    );
  }
}
