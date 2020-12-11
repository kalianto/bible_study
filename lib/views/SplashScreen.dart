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
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.blue[800],
            fontSize: 40.0,
          ),
        ),
        Text(
          'version 1.0',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 14.0,
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
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.amber[600],
        )
      ],
    ),
  );
}
