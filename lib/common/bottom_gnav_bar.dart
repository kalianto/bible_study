import 'package:bible_study/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bible_study/views/home/index.dart';
import 'package:bible_study/views/profile/index.dart';
import 'package:bible_study/views/settings/index.dart';
import 'package:bible_study/views/register/index.dart';

class BottomGNavBar extends StatefulWidget {
  @override
  _BottomGNavBarState createState() => _BottomGNavBarState();
}

class _BottomGNavBarState extends State<BottomGNavBar> with TickerProviderStateMixin {
  AnimationController animationController;
  int _selectedIndex = 0;

  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  List<Widget> _widgetOptions = <Widget>[
    Home(),
    Profile(),
    SettingsPage(),
    RegisterPage(),

  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: _buildBottomGNavBarMenu(context),
    );
  }

  Widget _buildBottomGNavBarMenu(BuildContext context) {
    return Container(
      height: 70.0,
      // height: 10 * SizeConfig.heightMultiplier,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))]),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 4),
          child: GNav(
              gap: 6,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              duration: Duration(milliseconds: 800),
              // tabBackgroundColor: Colors.blue,
              tabs: [
                GButton(
                    icon: FontAwesomeIcons.home,
                    text: ' Home',
                    iconColor: AppTheme.blueText,
                    backgroundColor: AppTheme.blueText,
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed('/home');
                    }),
                GButton(
                  icon: FontAwesomeIcons.bell,
                  text: 'Notifications',
                  iconColor: AppTheme.yellowText,
                  backgroundColor: AppTheme.yellowText,
                  onPressed: () => Navigator.of(context).pushNamed('/login'),
                ),
                GButton(
                    icon: FontAwesomeIcons.bible,
                    text: 'Reading',
                    iconColor: AppTheme.greenText,
                    backgroundColor: AppTheme.greenText,
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed('/profile');
                    }),
                GButton(
                    icon: FontAwesomeIcons.users,
                    text: '  COOL',
                    iconColor: AppTheme.redText,
                    backgroundColor: AppTheme.redText,
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed('/group');
                    }),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                  print('Current Index is ');
                  print(index);
                });
              }),
        ),
      ),
    );
  }
}
