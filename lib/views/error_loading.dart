import 'package:flutter/material.dart';

class ErrorLoading extends StatelessWidget {
  ErrorLoading({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(this.title),
        ),
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
            fontWeight: FontWeight.bold,
            color: Colors.blue[800],
            fontSize: 36,
          ),
        ),
        Text(
          'version 1.0',
          style: TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 50),
        Text(
          'Unable to initialise this app.',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ],
    ),
  );
}
