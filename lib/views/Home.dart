import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({Key key, this.title}) : super(key: key);

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
          'Bible Study 1',
          style: TextStyle(
            // fontWeight: FontWeight.w100,
            color: Colors.blue[800],
            fontSize: 48,
          ),
        ),
        Text(
          'version 1.0 2',
          style: TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 50),
        FlatButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          child: Text(
            'START',
            style: TextStyle(
              fontSize: 20,
              color: Colors.blue,
            ),
          ),
        )
      ],
    ),
  );
}
