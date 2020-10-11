import 'package:flutter/material.dart';
import 'package:bible_study/Router.dart';
import 'package:global_configuration/global_configuration.dart';

class BibleStudy extends StatelessWidget {
  // root of BibleStudy application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: GlobalConfiguration().getValue('appName'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[800],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // fontFamily: 'Overpass',
        // fontFamily: 'Heebo',
        // fontFamily: 'DancingScript',
        fontFamily: 'FiraSansCondensed',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 70.0, fontWeight: FontWeight.w900),
          headline2: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
          headline3: TextStyle(fontSize: 48.0, fontWeight: FontWeight.w900),
          headline4: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
          headline5: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
        )
      ),
      initialRoute: '/',
      onGenerateRoute: BaseRouter.route,
    );
  }
}
