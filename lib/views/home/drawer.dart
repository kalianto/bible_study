import 'package:flutter/material.dart';
import 'package:bible_study/app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerList {
  DrawerList(
    this.icon,
    this.title,
    this.link,
  );

  String title;
  Icon icon;
  String link;
}

class HomeDrawer extends StatelessWidget {
  HomeDrawer({Key key}) : super(key: key);

  final List<DrawerList> drawerList = <DrawerList>[
    DrawerList(Icon(FontAwesomeIcons.userCircle, color: AppTheme.redText), 'Profile', '/profile'),
    DrawerList(Icon(FontAwesomeIcons.envelope, color: AppTheme.yellowText), 'Messages', '/login'),
    DrawerList(Icon(FontAwesomeIcons.users, color: AppTheme.greenText), 'COOL', '/register'),
    DrawerList(Icon(FontAwesomeIcons.cog, color: AppTheme.blueText), 'Settings', '/settings'),
  ];

  @override
  Widget build(BuildContext context) {
    // return _build(context);
    return _buildDrawer(context);
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppTheme.blueText,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
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
                        child: Image.asset('assets/images/userImage.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 4),
                      child: Text(
                        'Oliver Mockingbird',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.nearlyWhite,
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
                      title: Text(drawerList[index].title, style: TextStyle(fontSize: 20)),
                      onTap: () {
                        Navigator.of(context).popAndPushNamed(drawerList[index].link);
                      },
                    );
                  },
                ),
              ),
            ),
            Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Sign Out',
                    style: TextStyle(
                      fontFamily: AppTheme.fontName,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppTheme.nearlyWhite,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  trailing: Icon(
                    FontAwesomeIcons.powerOff,
                    color: AppTheme.nearlyWhite,
                  ),
                  onTap: () {},
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
