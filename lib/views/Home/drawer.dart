import 'package:flutter/material.dart';
import 'package:bible_study/AppTheme.dart';

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
    DrawerList(Icon(Icons.account_circle), 'Profile', '/profile'),
    DrawerList(Icon(Icons.message), 'Messages', '/messages'),
    DrawerList(Icon(Icons.group), 'Group', '/group'),
    DrawerList(Icon(Icons.settings), 'Settings', '/settings'),
  ];

  @override
  Widget build(BuildContext context) {
    // return _build(context);
    return _buildDrawer(context);
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
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
                      'Phoebe Mockingbird',
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
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
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
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
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
                    color: AppTheme.darkText,
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing: Icon(
                  Icons.power_settings_new,
                  color: Colors.red,
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
    );
  }
}
