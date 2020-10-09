import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(this.title),
        // ),
        body: _buildHome(context)
      ),
    );
  }
}

Widget _buildHome(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'BibleStudy',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.blue[800],
            fontSize: 40.0,
            // fontStyle: FontStyle.italic,
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
            Navigator.pushNamed(context, '/login');
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
