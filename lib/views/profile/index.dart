import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_config.dart';
import '../../app_theme.dart';
import '../../common/child_page_appbar.dart';
import '../../models/profile.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
  AnimationController animationController;
  bool _editing;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _addressController = TextEditingController();
  final _suburbController = TextEditingController();
  final _stateController = TextEditingController();
  final _postcodeController = TextEditingController();
  String profileIcon = 'userImage.png';

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _editing = false;
    _loadProfile();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  void _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final key = AppConfig.profile;
    Profile profile = (Profile.fromJson(jsonDecode(prefs.getString(key))) ?? null);
    _setProfile(profile);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            //body: buildColumn(context),
            body: buildStack(context)));
  }

  Widget buildStack(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 205,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.zero,
                topRight: Radius.zero,
                bottomLeft: Radius.elliptical(650, 350),
                bottomRight: Radius.zero),
            color: AppTheme.darkGreen,
          ),
        ),
        ChildPageAppBar(title: 'Profile'),
        Container(
          padding: const EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
            profileHeader(context),
            loadProfile(context),
          ])),
        ),
      ],
    );
  }

  Widget buildColumn(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ChildPageAppBar(title: 'Profile'),
            profileHeader(context),
            loadProfile(context),
          ],
        ),
      ),
    );
  }

  Widget loadProfile(BuildContext context) {
    print('Selected Page: $_editing');
    return Container(
      child: AnimatedCrossFade(
        duration: const Duration(milliseconds: 500),
        firstChild: viewProfile(context),
        secondChild: editProfile(context),
        crossFadeState: _editing ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      ),
    );
    // return editProfile(context);
  }

  void _setProfile(Profile profile) {
    setState(() {
      _firstNameController.text = profile.firstName ?? null;
      _lastNameController.text = profile.lastName ?? null;
      _emailController.text = profile.email ?? null;
      _mobileController.text = profile.mobile ?? null;
      _suburbController.text = profile.suburb ?? null;
      _addressController.text = profile.address ?? null;
      _stateController.text = profile.state ?? null;
      _postcodeController.text = profile.postcode ?? null;
      profileIcon = profile.profileIcon ?? 'userImage.png';
    });
  }

  Widget editProfile(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 24, right: 24, bottom: 20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0),
              child: Text(
                'Personal',
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
                enabled: _editing,
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
                enabled: _editing,
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
                enabled: _editing,
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
                enabled: _editing,
                // icon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Text(
                'Address',
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
              controller: _addressController,
              maxLines: 3,
              decoration: InputDecoration(
                enabledBorder: AppTheme.inputBorderless,
                focusedBorder: AppTheme.inputBorderless,
                border: AppTheme.inputBorderless,
                filled: true,
                fillColor: AppTheme.notWhite,
                labelText: 'Address',
                enabled: _editing,
                // icon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _suburbController,
              decoration: InputDecoration(
                enabledBorder: AppTheme.inputBorderless,
                focusedBorder: AppTheme.inputBorderless,
                border: AppTheme.inputBorderless,
                filled: true,
                fillColor: AppTheme.notWhite,
                labelText: 'Suburb/Region/Town',
                enabled: _editing,
                // icon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              child: Row(children: <Widget>[
                Expanded(
                    child: TextField(
                  controller: _stateController,
                  decoration: InputDecoration(
                    enabledBorder: AppTheme.inputBorderless,
                    focusedBorder: AppTheme.inputBorderless,
                    border: AppTheme.inputBorderless,
                    filled: true,
                    fillColor: AppTheme.notWhite,
                    labelText: 'State/Province',
                    enabled: _editing,
                    // icon: Icon(Icons.lock),
                  ),
                )),
                Container(width: 10),
                Expanded(
                    child: TextField(
                  controller: _postcodeController,
                  decoration: InputDecoration(
                    enabledBorder: AppTheme.inputBorderless,
                    focusedBorder: AppTheme.inputBorderless,
                    border: AppTheme.inputBorderless,
                    filled: true,
                    fillColor: AppTheme.notWhite,
                    labelText: 'Postcode',
                    enabled: _editing,
                    // icon: Icon(Icons.lock),
                  ),
                )),
              ]),
            ),
            SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final key = AppConfig.profile;
                    Profile updatedProfile = new Profile(
                      email: _emailController.text,
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      mobile: _mobileController.text,
                      address: _addressController.text,
                      suburb: _suburbController.text,
                      state: _stateController.text,
                      postcode: _postcodeController.text,
                      profileIcon: profileIcon,
                    );

                    /// save profile to SharedPreferences
                    prefs.setString(key, jsonEncode(updatedProfile.toJson()));

                    /// Update State for the form controller
                    _setProfile(updatedProfile);

                    setState(() {
                      _editing = !_editing;
                    });
                  },
                  child: Text('SAVE', style: TextStyle(fontSize: 20)),
                  style: ButtonStyle(
                    // textColor: Colors.white,
                    // padding: const EdgeInsets.all(0.0),
                    backgroundColor: MaterialStateProperty.all<Color>(AppTheme.primarySwatch),
                  )),
            ),
          ]),
    );
  }

  Widget viewProfile(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 10, left: 24, right: 24, bottom: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(0),
                child: Text(
                  'Personal Details',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    letterSpacing: 0.27,
                    color: AppTheme.darkerText,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                child: Row(children: <Widget>[
                  Container(
                    child: FaIcon(
                      FontAwesomeIcons.user,
                      color: AppTheme.darkGreen,
                      size: 18,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 2, color: AppTheme.darkGreen),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                  ),
                  Container(width: 10),
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Full Name', style: TextStyle(color: AppTheme.darkGreen)),
                          Text('${_firstNameController.text} ${_lastNameController.text}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.w400)),
                        ]),
                  )
                ]),
              ),
              SizedBox(height: 20),
              Container(
                child: Row(children: <Widget>[
                  Container(
                    child: FaIcon(
                      FontAwesomeIcons.envelope,
                      color: AppTheme.darkGreen,
                      size: 18,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 2, color: AppTheme.darkGreen),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                  ),
                  Container(width: 10),
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Email Address', style: TextStyle(color: AppTheme.darkGreen)),
                          Text(_emailController.text,
                              style: TextStyle(fontWeight: FontWeight.w400)),
                        ]),
                  )
                ]),
              ),
              SizedBox(height: 20),
              Container(
                child: Row(children: <Widget>[
                  Container(
                    child: FaIcon(
                      FontAwesomeIcons.phone,
                      color: AppTheme.darkGreen,
                      size: 18,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 2, color: AppTheme.darkGreen),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                  ),
                  Container(width: 10),
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Mobile Number', style: TextStyle(color: AppTheme.darkGreen)),
                          Text(_mobileController.text ?? '',
                              style: TextStyle(fontWeight: FontWeight.w400)),
                        ]),
                  )
                ]),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Text(
                  'Address',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    letterSpacing: 0.27,
                    color: AppTheme.darkerText,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                child: Row(children: <Widget>[
                  Container(
                    child: FaIcon(
                      FontAwesomeIcons.building,
                      color: AppTheme.darkGreen,
                      size: 18,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 2, color: AppTheme.darkGreen),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                  ),
                  Container(width: 10),
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(_addressController.text,
                              style: TextStyle(color: AppTheme.darkGreen)),
                          Text(
                              '${_suburbController.text}${_stateController.text == '' ? "" : ","}  ${_stateController.text} ${_postcodeController.text}',
                              style: TextStyle(fontWeight: FontWeight.w400)),
                        ]),
                  )
                ]),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Text(
                  'COOL Group',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    letterSpacing: 0.27,
                    color: AppTheme.darkerText,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                  child: Row(children: <Widget>[
                Container(
                  child: FaIcon(
                    FontAwesomeIcons.grinHearts,
                    color: AppTheme.darkGreen,
                    size: 18,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 2, color: AppTheme.darkGreen),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                ),
                Container(width: 10),
                Expanded(
                  child: RichText(
                      text: TextSpan(
                    style: TextStyle(color: AppTheme.darkGreen, fontFamily: AppTheme.fontName),
                    children: <TextSpan>[
                      TextSpan(text: 'You haven\'t joined any group. '),
                      TextSpan(
                          text: 'Join Now',
                          style: TextStyle(color: AppTheme.blueText, fontWeight: FontWeight.w600),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushNamed('/cool-group');
                            })
                    ],
                  )),
                ),
              ]))
            ]));
  }

  Widget profileHeader(BuildContext context) {
    return Container(
        child: Wrap(
      children: <Widget>[
        Container(
          child: new Container(
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: AppTheme.boxDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          if (_editing) {
                            _showProfileIconDialog(context);
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                            child: Image.asset(
                              'assets/images/$profileIcon',
                            ),
                          ),
                        )),
                    Container(width: 15.0),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${_firstNameController.text} ${_lastNameController.text}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.nearlyBlack,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          _emailController.text,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppTheme.darkerText,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )),
                    _editing
                        ? CloseButton(
                            onPressed: () {
                              setState(() {
                                _editing = !_editing;
                              });
                            },
                            color: AppTheme.redText,
                            // padding: const EdgeInsets.all(0),
                          )
                        : IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.pen,
                              size: 18,
                            ),
                            onPressed: () {
                              setState(() {
                                _editing = !_editing;
                              });
                            },
                            // color: AppTheme.primarySwatch,
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }

  List<SimpleDialogOption> _generateProfileIconList(BuildContext context) {
    return List.generate(
        8,
        (i) => SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'userImage-${i + 1}.png');
              },
              child: Row(children: <Widget>[
                Container(
                    height: 32,
                    width: 32,
                    color: AppTheme.darkGrey.withOpacity(0.1),
                    child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                          child: Image.asset(
                            'assets/images/userImage-${i + 1}.png',
                          ),
                        ))),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('Profile ${i + 1}'),
                )
              ]),
            ));
  }

  _showProfileIconDialog(BuildContext context) {
    SimpleDialog dialog = SimpleDialog(
      title: const Text('Select Profile Icon'),
      children: _generateProfileIconList(context),
    );

    Future futureValue = showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });

    futureValue.then((newProfileIcon) {
      /// save profile icon to sharedPreference
      setState(() {
        profileIcon = newProfileIcon;
      });
    });
  }
}
