import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../app_theme.dart';

Widget buildSignInPage(BuildContext context) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'GEMA',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: AppTheme.nearlyBlack,
              fontSize: 40.0,
              letterSpacing: 14.0,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'Gerakan Membaca Alkitab Setahun',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 14.0,
              color: AppTheme.nearlyBlack,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),
          Text(
            'We detected a profile on this device.\nChoose from one of below options to sign in.',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 14.0,
              color: AppTheme.nearlyBlack,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          FloatingActionButton.extended(
            heroTag: 'signup_email',
            label: Text(
              'Sign In with Email',
              style: TextStyle(
                color: AppTheme.nearlyBlack,
              ),
            ),
            backgroundColor: AppTheme.white,
            icon: Icon(
              FontAwesomeIcons.envelope,
              size: 20.0,
              color: AppTheme.nearlyBlack,
            ),
            onPressed: () {
              Navigator.of(context).popAndPushNamed('/login');
            },
          ),
        ],
      ),
    ),
  );
}
