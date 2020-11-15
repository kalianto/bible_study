import 'package:flutter/material.dart';
import 'package:bible_study/views/HomeDrawer.dart';

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

  // Widget _buildHomeDrawer() {
  //   return Drawer(
  //     child: ListView(
  //       padding: EdgeInsets.zero,
  //       children: <Widget>[
  //         DrawerHeader(
  //           decoration: BoxDecoration(
  //             color: Colors.amber[600],
  //           ),
  //           padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
  //           child: ListTile(
  //             title: Text(
  //               'Doris Suhardi',
  //               style: TextStyle(
  //                 fontSize: 22,
  //                 color: Colors.black,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             subtitle: Text('0430355556'),
  //             leading: CircleAvatar(
  //               child: Icon(
  //                 Icons.person,
  //               ),
  //               radius: 25,
  //             ),
  //             trailing: IconButton(
  //               icon: Icon(Icons.close),
  //               onPressed: _closeHomeDrawer,
  //             ),
  //           ),
  //           // child: Row(
  //           //   children: [
  //           //     Expanded(
  //           //       child: Text(
  //           //         'Kal Wong',
  //           //         style: TextStyle(
  //           //           fontSize: 28,
  //           //           color: Colors.black,
  //           //           fontWeight: FontWeight.bold,
  //           //         ),
  //           //       ),
  //           //     ),
  //           //     FlatButton(
  //           //       onPressed: _closeHomeDrawer,
  //           //       child: Icon(
  //           //         Icons.close,
  //           //       ),
  //           //       padding: EdgeInsets.only(left: 50, right: 0),
  //           //     ),
  //           //   ],
  //           //   crossAxisAlignment: CrossAxisAlignment.baseline,
  //           //   mainAxisAlignment: MainAxisAlignment.start,
  //           // ),
  //         ),
  //         ListTile(
  //           leading: Icon(Icons.message),
  //           title: Text('Messages', style: TextStyle(fontSize: 20)),
  //           onTap: () {
  //             Navigator.of(context).popAndPushNamed('/messages');
  //           },
  //         ),
  //         ListTile(
  //           leading: Icon(Icons.account_circle),
  //           title: Text('Profile', style: TextStyle(fontSize: 20)),
  //           onTap: () {
  //             Navigator.of(context).popAndPushNamed('/profile');
  //           },
  //         ),
  //         ListTile(
  //           leading: Icon(Icons.settings),
  //           title: Text('Settings', style: TextStyle(fontSize: 20)),
  //           onTap: () {
  //             Navigator.of(context).popAndPushNamed('/settings');
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            'Home Page App Bar',
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
          backgroundColor: Colors.amber[50],
          elevation: 0.0,
        ),
        body: _buildHome(context),
        // drawer: _buildHomeDrawer(),
        drawer: const HomeDrawer(),
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
          'Home Page',
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
