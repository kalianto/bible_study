import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../app_theme.dart';
import '../../helpers/secure_storage.dart';
import '../../models/profile.dart';
import '../common/loadProfile.dart';
import '../common/signInWidget.dart';
import '../common/signUpWidget.dart';

class DrawerList {
  DrawerList(
    this.icon,
    this.title,
    this.subtitle,
    this.link,
  );

  String title;
  String subtitle;
  Icon icon;
  String link;
}

class HomeDrawer extends StatelessWidget {
  HomeDrawer({Key key}) : super(key: key);

  final secureStorage = SecureStorage();

  final List<DrawerList> drawerList = <DrawerList>[
    DrawerList(Icon(FontAwesomeIcons.userCircle, color: AppTheme.lightPurple), 'Profile',
        'Edit personal details', '/profile'),
    DrawerList(Icon(FontAwesomeIcons.bible, color: AppTheme.darkGrey), 'Bible',
        'Bible in different languages', '/bible'),
    DrawerList(Icon(FontAwesomeIcons.users, color: AppTheme.greenText), 'COOL',
        'COOL group details', '/cool-group'),
    DrawerList(Icon(FontAwesomeIcons.comments, color: AppTheme.blueText), 'Feedback',
        'Send us feedback or questions', '/feedback'),
    DrawerList(Icon(FontAwesomeIcons.cog, color: AppTheme.mandarin), 'Settings',
        'Personal settings, App settings', '/settings'),
    // DrawerList(Icon(FontAwesomeIcons.fileAlt, color: AppTheme.blueText), 'Sample Pages',
    //     'Other pages template', '/pages'),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: checkProfile(context),
    );
  }

  Widget checkProfile(BuildContext context) {
    return FutureBuilder(
      future: loadProfile(),
      builder: (context, snapshot) {
        if (ConnectionState.active != null && !snapshot.hasData) {
          return buildSignUpPage(context);
        }
        if (ConnectionState.done != null && snapshot.hasError) {
          return buildSignUpPage(context);
        }
        if (ConnectionState.done != null && snapshot.data != null) {
          Profile profile = snapshot.data['profile'];
          bool isLoggedIn = snapshot.data['isLoggedIn'];
          if (profile.isEmpty()) {
            return buildSignUpPage(context);
          }
          if (!isLoggedIn) {
            return buildSignInPage(context);
          }
          return buildProfilePage(context, profile);
        }
        return buildSignUpPage(context);
      },
    );
  }

  Widget buildProfilePage(BuildContext context, Profile profile) {
    return Container(
      color: AppTheme.darkGreen,
      child: Stack(
        children: <Widget>[
          buildProfileMenu(context, profile),
          buildProfilePicture(context, profile),
        ],
      ),
    );
  }

  Widget buildProfilePicture(BuildContext context, Profile profile) {
    return Container(
      width: double.infinity,
      height: 200,
      // padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: AppTheme.grey.withOpacity(0.6),
                    offset: const Offset(2.0, 4.0),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(60.0)),
                child: Image.asset('assets/images/' + profile.getProfileIcon()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 4),
              child: Text(
                profile.fullName(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.grey,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileMenu(BuildContext context, Profile profile) {
    return Container(
      padding: const EdgeInsets.only(top: 90),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 70),
              decoration: BoxDecoration(
                color: AppTheme.lightGreen,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                itemCount: drawerList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: drawerList[index].icon,
                    title: Text(
                      drawerList[index].title,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.grey,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.5,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed(drawerList[index].link);
                    },
                    subtitle: Text(drawerList[index].subtitle, style: AppTheme.caption),
                  );
                },
              ),
            ),
          ),
          buildSignOutMenu(context),
        ],
      ),
    );
  }

  Widget buildSignOutMenu(BuildContext context) {
    return ListTile(
      title: Text(
        'Log Out',
        style: TextStyle(
          fontFamily: AppTheme.fontName,
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: AppTheme.grey,
        ),
        textAlign: TextAlign.left,
      ),
      trailing: Icon(
        FontAwesomeIcons.powerOff,
        color: AppTheme.grey,
        size: 20,
      ),
      onTap: () {
        _showLogoutDialog(context);
      },
    );
  }

  Future<bool> _showLogoutDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            title: Text('Log out'),
            content: Text('Are you sure?'),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  bool isLoggedIn = await secureStorage.getIsLoggedIn();
                  if (isLoggedIn) {
                    await secureStorage.setIsLoggedIn(false);
                  }
                  // remove all history from the navigation stack and go to home
                  // tapping back button will not replay history, this is what we want
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                  return true;
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppTheme.darkGreen,
                ),
                child: Text(
                  'Yes',
                  style: TextStyle(
                    color: AppTheme.white,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  return false;
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppTheme.redText,
                ),
                child: Text(
                  'No',
                  style: TextStyle(
                    color: AppTheme.white,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
