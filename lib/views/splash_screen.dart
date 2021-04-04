import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_theme.dart';
import '../models/profile.dart';
import '../app_config.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Profile profile;
  String errorMessage;
  bool isLoggedIn;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: _buildHome(context, widget.title),
    ));
  }

  void _loadProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = AppConfig.profile;
      Profile _profile = (prefs.getString(key) != null)
          ? Profile.fromJson(jsonDecode(prefs.getString(key)))
          : new Profile();
      setState(() {
        profile = _profile;
        isLoggedIn = prefs.getBool(AppConfig.isLoggedIn) ?? false;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        errorMessage = 'Click Start to continue';
      });
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
              onPressed: () async {
                await _loadProfile();
                if (!isLoggedIn) {
                  Navigator.pushNamed(context, '/login');
                } else if (profile.email == null) {
                  Navigator.pushNamed(context, '/register');
                  // } else if (profile.email == '') {
                  //   Navigator.pushNamed(context, '/login');
                } else {
                  Navigator.pushNamed(context, '/home');
                }
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
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Text(errorMessage ?? '',
                  style: TextStyle(
                    color: AppTheme.notWhite,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
