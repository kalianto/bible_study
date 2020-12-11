import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    void _closeHomeDrawer() {
      Navigator.of(context).pop();
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.amber[600],
            ),
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            child: ListTile(
              title: Text(
                'Phoebe Mockingbird',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('0430111111'),
              leading: CircleAvatar(
                child: Icon(
                  Icons.person,
                ),
                radius: 25,
              ),
              trailing: IconButton(
                icon: Icon(Icons.close),
                onPressed: _closeHomeDrawer,
              ),
              
            ),
            // child: Row(
            //   children: [
            //     Expanded(
            //       child: Text(
            //         'Kal Wong',
            //         style: TextStyle(
            //           fontSize: 28,
            //           color: Colors.black,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ),
            //     FlatButton(
            //       onPressed: _closeHomeDrawer, 
            //       child: Icon(
            //         Icons.close,
            //       ),
            //       padding: EdgeInsets.only(left: 50, right: 0),
            //     ),
            //   ],
            //   crossAxisAlignment: CrossAxisAlignment.baseline,
            //   mainAxisAlignment: MainAxisAlignment.start,
            // ),
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
}
