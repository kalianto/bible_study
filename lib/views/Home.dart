import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openHomeDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  void _closeHomeDrawer() {
    Navigator.of(context).pop();
  }

  Widget _buildHomeDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.amber[600],
            ),
            child: Text(
              'Kal Wong',
              style: TextStyle(
                fontSize: 28,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Messages', style: TextStyle(fontSize: 20)),
            onTap: () {
              Navigator.of(context).popAndPushNamed('/messages');
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile', style: TextStyle(fontSize: 20)),
            onTap: () {
              Navigator.of(context).popAndPushNamed('/profile');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings', style: TextStyle(fontSize: 20)),
            onTap: () {
              Navigator.of(context).popAndPushNamed('/settings');
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            'Bible Study',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: _openHomeDrawer,
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                color: Colors.black,
              );
            },
          ),
          backgroundColor: Colors.white,
        ),
        body: _buildHome(context),
        drawer: _buildHomeDrawer(),
      ),
    );
  }
}

Widget _buildHome(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Bible Study 1',
          style: TextStyle(
            // fontWeight: FontWeight.w100,
            color: Colors.blue[800],
            fontSize: 48,
          ),
        ),
        Text(
          'version 1.0 2',
          style: TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 50),
        FlatButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          child: Text(
            'START',
            style: TextStyle(
              fontSize: 20,
              color: Colors.blue,
            ),
          ),
        )
      ],
    ),
  );
}
