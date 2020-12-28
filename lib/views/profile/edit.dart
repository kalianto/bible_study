import 'package:flutter/material.dart';

import '../../app_theme.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 24, right: 24, bottom: 20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0),
              child: Text(
                'Edit Profile',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  letterSpacing: 0.27,
                  color: AppTheme.darkerText,
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                enabledBorder: AppTheme.inputBorderless,
                focusedBorder: AppTheme.inputBorderless,
                labelText: 'First Name',
                filled: true,
                fillColor: AppTheme.notWhite,
                // icon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                enabledBorder: AppTheme.inputBorderless,
                focusedBorder: AppTheme.inputBorderless,
                labelText: 'Last Name',
                filled: true,
                fillColor: AppTheme.notWhite,
                // icon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                enabledBorder: AppTheme.inputBorderless,
                focusedBorder: AppTheme.inputBorderless,
                border: AppTheme.inputBorderless,
                filled: true,
                fillColor: AppTheme.notWhite,
                labelText: 'Email',
                // icon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _mobileController,
              decoration: InputDecoration(
                enabledBorder: AppTheme.inputBorderless,
                focusedBorder: AppTheme.inputBorderless,
                border: AppTheme.inputBorderless,
                filled: true,
                fillColor: AppTheme.notWhite,
                labelText: 'Mobile',
                // icon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Text(
                'Edit Address',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  letterSpacing: 0.27,
                  color: AppTheme.darkerText,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _mobileController,
              maxLines: 3,
              decoration: InputDecoration(
                enabledBorder: AppTheme.inputBorderless,
                focusedBorder: AppTheme.inputBorderless,
                border: AppTheme.inputBorderless,
                filled: true,
                fillColor: AppTheme.notWhite,
                labelText: 'Address',
                // icon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _mobileController,
              decoration: InputDecoration(
                enabledBorder: AppTheme.inputBorderless,
                focusedBorder: AppTheme.inputBorderless,
                border: AppTheme.inputBorderless,
                filled: true,
                fillColor: AppTheme.notWhite,
                labelText: 'Suburb',
                // icon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              child: Row(children: <Widget>[
                Expanded(
                    child: TextField(
                      controller: _mobileController,
                      decoration: InputDecoration(
                        enabledBorder: AppTheme.inputBorderless,
                        focusedBorder: AppTheme.inputBorderless,
                        border: AppTheme.inputBorderless,
                        filled: true,
                        fillColor: AppTheme.notWhite,
                        labelText: 'State',
                        // icon: Icon(Icons.lock),
                      ),
                    )),
                Container(width: 10),
                Expanded(
                    child: TextField(
                      controller: _mobileController,
                      decoration: InputDecoration(
                        enabledBorder: AppTheme.inputBorderless,
                        focusedBorder: AppTheme.inputBorderless,
                        border: AppTheme.inputBorderless,
                        filled: true,
                        fillColor: AppTheme.notWhite,
                        labelText: 'Postcode',
                        // icon: Icon(Icons.lock),
                      ),
                    )),
              ]),
            ),
            SizedBox(height: 20.0),
            Center(
              child: RaisedButton(
                onPressed: () {},
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Text('SAVE', style: TextStyle(fontSize: 20)),
                color: AppTheme.primarySwatch,
              ),
            ),
          ]),
    );
  }
}
