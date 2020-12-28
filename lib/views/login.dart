import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
// import 'package:firebase_auth/firebase_auth.dart' as Auth;
// import 'package:http/http.dart' as http;

import '../app_theme.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                SizedBox(height: 16.0),
                Text(
                  'BibleStudy',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkGreen,
                    fontSize: 36,
                  ),
                ),
                Text(
                  'version 1.0',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: AppTheme.darkGreen,
                  ),
                ),
                SizedBox(height: 50.0),
                Text(
                  'Enter your details below to sign in',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppTheme.darkGreen,
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    // icon: Icon(Icons.person),
                    // filled: true,
                    enabledBorder: AppTheme.inputBorder,
                    focusedBorder: AppTheme.inputBorder,
                    labelStyle: TextStyle(
                      color: AppTheme.darkGreen,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    // filled: true,
                    enabledBorder: AppTheme.inputBorder,
                    focusedBorder: AppTheme.inputBorder,
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: AppTheme.darkGreen,
                    ),
                    // icon: Icon(Icons.lock),
                  ),
                  obscureText: true, // this is password field
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        'Don\'t have account?',
                        style: TextStyle(
                          color: AppTheme.blueText,
                        ),
                      ),
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/register');
                      },
                    ),
                    FlatButton(
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.blueText,
                        ),
                      ),
                      onPressed: () async {
                        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
                        print('Running on ${androidInfo.model}');
                        print('Android Info');
                        print(Platform.isAndroid);
                        print('Device Info');
                        print(deviceInfo.hashCode);
                        // try {
                        //   var url = 'http://localhost:3001/auth';
                        //   var response = await http.post(url, body: {});
                        //   print("RESPONSE");
                        //   print(response);
                        // } catch (e) {
                        //   print("LOGIN ERROR");
                        //   print(e);
                        // }
                        // try {
                        //   Auth.User user = (await Auth.FirebaseAuth.instance.signInWithEmailAndPassword(
                        //     email: _usernameController.text,
                        //     password: _passwordController.text,
                        //   ))
                        //       .user;
                        //   if (user != null) {
                        //     // UserUpdateInfo updateUser = UserUpdateInfo();
                        //     // updateUser.displayName = _usernameController.text;
                        //     // user.updateProfile(updateUser);
                        //     // Navigator.of(context).pushNamed(AppRoutes.menu);
                        //     print('User');
                        //     print(user);
                        //   }
                        // } catch (e) {
                        //   print('Error');
                        //   print(_usernameController.text);
                        //   print(e);
                        //   _usernameController.text = "";
                        //   _passwordController.text = "";
                        //   // _repasswordController.text = "";
                        //   // _emailController.text = "";
                        //   // TODO: alertdialog with error
                        // }
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 120.0),
          ],
        ),
      ),
      // backgroundColor: Colors.blue.shade300,
    );
  }
}
