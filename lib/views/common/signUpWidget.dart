import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../app_theme.dart';

Widget buildSignUpPage(BuildContext context) {
  return Container(
    width: double.infinity,
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
          SizedBox(height: 30),
          FloatingActionButton.extended(
            heroTag: 'signup_email',
            label: Text(
              'Sign up with Email',
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
              Navigator.of(context).popAndPushNamed('/register');
            },
          ),
          SizedBox(height: 20),
          FloatingActionButton.extended(
            heroTag: 'signup_google',
            label: Text(
              'Sign up with Google',
              style: TextStyle(
                color: AppTheme.nearlyWhite,
              ),
            ),
            // backgroundColor: AppTheme.white,
            icon: Icon(
              FontAwesomeIcons.google,
              size: 20.0,
              color: AppTheme.nearlyWhite,
            ),
            onPressed: () {},
          ),
          SizedBox(height: 20),
          FloatingActionButton.extended(
            heroTag: 'signup_apple',
            label: Text(
              'Sign up with Apple',
              style: TextStyle(
                color: AppTheme.nearlyBlack,
              ),
            ),
            backgroundColor: AppTheme.lightGrey,
            icon: Icon(
              FontAwesomeIcons.apple,
              size: 20.0,
              color: AppTheme.nearlyBlack,
            ),
            onPressed: () {},
          ),
        ],
      ),
    ),
  );
}
