import 'package:flutter/material.dart';
import 'views/ErrorLoading.dart';
import 'Router.dart';

class BibleStudy extends StatelessWidget {
  // root of BibleStudy application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bible Study',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      onGenerateRoute: Router.route,
    );
  }
}
