import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_config.dart';
import '../app_theme.dart';
import '../models/profile.dart';

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
      ),
    );
  }

  void _loadProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = AppConfig.profile;
      Profile _profile = (prefs.getString(key) != null) ? Profile.fromJson(jsonDecode(prefs.getString(key))) : new Profile();
      setState(() {
        profile = _profile;
        isLoggedIn = prefs.getBool(AppConfig.isLoggedIn) ?? false;
      });
    } catch (e) {

      setState(() {
        errorMessage = 'Click Start to continue';
      });
    }
  }

  Widget _buildHome(BuildContext context, String title) {
    return Container(
      decoration: BoxDecoration(
        // color: AppTheme.purple,
        image: DecorationImage(
          image: AssetImage('assets/backgrounds/nature-03.jpg'),
          fit: BoxFit.cover,
          // repeat: ImageRepeat.repeatY
        ),
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
              textAlign: TextAlign.center,
            ),
            Text(
              'Gerakan Membaca Alkitab Setahun',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 14.0,
                color: AppTheme.notWhite,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            // FloatingActionButton(
            //   onPressed: () {
            //     _loadProfile();
            //     if (!isLoggedIn) {
            //       Navigator.pushNamed(context, '/login');
            //     } else if (profile.email == null) {
            //       Navigator.pushNamed(context, '/register');
            //       // } else if (profile.email == '') {
            //       //   Navigator.pushNamed(context, '/login');
            //     } else {
            //       Navigator.pushNamed(context, '/home');
            //     }
            //   },
            //   child:
            //       const FaIcon(FontAwesomeIcons.arrowRight, size: 20, color: AppTheme.nearlyWhite),
            //   backgroundColor: AppTheme.blueText.withOpacity(0.8),
            //   shape: CircleBorder(
            //       side: BorderSide(
            //           width: 5.0,
            //           color: AppTheme.white.withOpacity(0.4),
            //           style: BorderStyle.solid)),
            //   elevation: 2.0,
            // ),
            ElevatedButton(
              onPressed: () {
                // _loadProfile();
                // // print(profile);
                // if (profile.email == null) {
                //   Navigator.pushNamed(context, '/register');
                // } else if (!isLoggedIn) {
                //   Navigator.pushNamed(context, '/login');
                //   // } else if (profile.email == null) {
                //   //   Navigator.pushNamed(context, '/register');
                // } else {
                Navigator.pushNamed(context, '/home');
                // }
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: const FaIcon(
                  FontAwesomeIcons.arrowRight,
                  size: 24,
                  color: AppTheme.nearlyWhite,
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: new CircleBorder(
                  side: BorderSide(
                    width: 5.0,
                    color: AppTheme.white.withOpacity(0.4),
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                errorMessage ?? '',
                style: TextStyle(
                  color: AppTheme.notWhite,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
