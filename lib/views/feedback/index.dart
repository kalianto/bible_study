import 'package:flutter/material.dart';

import '../../app_theme.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Feedback'),
              backgroundColor: AppTheme.blueText,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(children: <Widget>[
                  Text(
                    'Help us to improve. ' +
                        'Let us know what you think\n' +
                        'You can also report a problem.',
                    style: AppTheme.body1,
                  ),
                  SizedBox(height: 20),
                  Align(
                    child: Text('Subject', style: AppTheme.subtitle1),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _subjectController,
                    decoration: InputDecoration(
                      enabledBorder: AppTheme.inputBorderless,
                      focusedBorder: AppTheme.inputBorderless,
                      filled: true,
                      fillColor: AppTheme.notWhite,
                      // icon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    child: Text('Message', style: AppTheme.subtitle1),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      enabledBorder: AppTheme.inputBorderless,
                      focusedBorder: AppTheme.inputBorderless,
                      filled: true,
                      fillColor: AppTheme.notWhite,
                      // icon: Icon(Icons.person),
                    ),
                    maxLines: 5,
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Submit'),
                  ))
                ]),
              ),
            )));
  }
}
