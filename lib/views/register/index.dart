import 'package:flutter/material.dart';

import '../../app_config.dart';
import '../../app_theme.dart';
import '../../helpers/helper.dart' as Helper;
import '../../helpers/secure_storage.dart';
import '../../models/profile.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final secureStorage = SecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                SizedBox(height: 16.0),
                Text(
                  AppConfig.appName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.blueText,
                    fontSize: 36,
                  ),
                ),
                Text(
                  AppConfig.appDescription,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: AppTheme.blueText,
                  ),
                ),
                SizedBox(height: 50.0),
                Text(
                  'Enter your details below to register your details',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppTheme.blueText,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    enabledBorder: AppTheme.inputBorderBlue,
                    focusedBorder: AppTheme.inputBorderBlue,
                    labelText: 'Email Address',
                    filled: true,
                    fillColor: AppTheme.blueText.withOpacity(0.3),
                    // icon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    enabledBorder: AppTheme.inputBorderBlue,
                    focusedBorder: AppTheme.inputBorderBlue,
                    border: AppTheme.inputBorderBlue,
                    filled: true,
                    fillColor: AppTheme.blueText.withOpacity(0.3),
                    labelText: 'Password',
                    // icon: Icon(Icons.lock),
                  ),
                  obscureText: true, // this is password field
                ),
                SizedBox(height: 20.0),
                Text(
                  'By signing up, you agree to our Terms, Data Policy and Cookies Policy',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.blueText,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 20.0),
                TextButton(
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(
                      fontSize: 20,
                      color: AppTheme.white,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: TextButton.styleFrom(
                      primary: AppTheme.blueText,
                      backgroundColor: AppTheme.blueText,
                      padding: const EdgeInsets.symmetric(horizontal: 20)),
                  onPressed: () async {
                    //Navigator.pushNamed(context, '/home');
                    // try {
                    //   Auth.User user = (await Auth.FirebaseAuth.instance.createUserWithEmailAndPassword(
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
                    String emailAddress = _usernameController.text;
                    bool emailValid = Helper.isValidEmail(emailAddress);
                    if (!emailValid) {
                      Helper.showAlertDialog(
                          'Invalid Email Address', 'Please enter a valid email address.', context);
                    } else {
                      // final prefs = await SharedPreferences.getInstance();
                      // final key = AppConfig.profile;
                      // prefs.setString(key, jsonEncode({'email': emailAddress}));
                      // prefs.setBool(AppConfig.isLoggedIn, true);

                      /// secure storage implementation
                      Profile profile = new Profile(email: emailAddress);
                      await secureStorage.setProfile(profile);
                      Navigator.popAndPushNamed(context, '/home');
                    }
                  },
                ),
                SizedBox(height: 10.0),
                Divider(),
                TextButton(
                  child: Text(
                    'Have an account?',
                    style: TextStyle(
                      color: AppTheme.blueText,
                    ),
                  ),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/login');
                  },
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
