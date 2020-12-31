import 'package:bible_study/app_theme.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildHome(context, this.title),
      ),
    );
  }
}

Widget _buildHome(BuildContext context, String title) {
  return Container(
    decoration: BoxDecoration(
      color: AppTheme.purple,
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: AppTheme.notWhite,
              fontSize: 40.0,
              letterSpacing: 14.0,
            ),
          ),
          Text(
            'COmmunity Of Love',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 14.0,
              color: AppTheme.notWhite,
            ),
          ),
          SizedBox(height: 50),
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            label: Text(
              'START',
              style: TextStyle(
                fontSize: 24,
                color: AppTheme.yellowText,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: AppTheme.blueText.withOpacity(0.8),
          )
        ],
      ),
    ),
  );
}
