import 'package:flutter/material.dart';
import 'package:sendgrid_mailer/sendgrid_mailer.dart';

import '../../app_theme.dart';
import '../common/simpleDialog.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _subjectController.dispose();
    _messageController.dispose();
  }

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
            child: Column(
              children: <Widget>[
                Text(
                  'Help us to improve. ' + 'Let us know what you think\n' + 'You can also report a problem.',
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
                    onPressed: () async {
                      final mailer = Mailer('API_KEY');
                      final toAddress = Address('kalianto@gmail.com');
                      final fromAddress = Address('kalianto@outlook.com');
                      final content = Content('text/plain', _messageController.text);
                      final subject = 'CooLTest From: ' + _subjectController.text;
                      final personalization = Personalization([toAddress]);

                      final email = Email([personalization], fromAddress, subject, content: [content]);

                      /// Show sending dialog
                      showSimpleDialog(context, 'Sending Feedback', 'Please wait....\nYour feedback is being sent.');

                      mailer.send(email).then(
                        (result) {
                          _messageController.text = '';
                          _subjectController.text = '';

                          // close sending dialog
                          Navigator.pop(context);

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Feedback Sent'),
                                content: Text('Your feedback is valuable. We will get back to you.'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Close'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                    child: Text('Submit'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
