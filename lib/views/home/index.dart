// import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

// import 'package:timezone/timezone.dart' as tz;

import '../../providers/my_bible.dart';
import 'bottom_bar.dart';
import 'daily_reading_item.dart';
import 'date_selector.dart';
import 'drawer.dart';
import 'home_app_bar.dart';
import 'rhema.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double topBarOpacity = 1.0;

  DateTime date;
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    date = new DateTime.now();
    requestPermissions();

    // var androidSettings = AndroidInitializationSettings('app_icon');
    // var iOSSettings = IOSInitializationSettings(
    //   requestSoundPermission: false,
    //   requestBadgePermission: false,
    //   requestAlertPermission: false,
    // );
    //
    // var initSetttings = InitializationSettings(
    //   android: androidSettings,
    //   iOS: iOSSettings,
    //   macOS: null,
    // );
    // flutterLocalNotificationsPlugin.initialize(initSetttings,
    //     onSelectNotification: onClickNotification);
  }

  void setDate(DateTime newDate) {
    setState(() {
      date = newDate;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void requestPermissions() {
    // flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
    //     ?.requestPermissions(
    //       alert: true,
    //       badge: true,
    //       sound: true,
    //     );
  }

  Future onClickNotification(String payload) async {
    print('I got something, dude');
    // String fileName = await _downloadAndSaveFile(
    //     'https://via.placeholder.com/800x200', 'attachment_img.jpg');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyBible>(builder: (context, myBible, child) {
      return SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: HomeAppBar(date: date, myBible: myBible),
          ),
          body: buildHomeContent(context, myBible),
          drawer: HomeDrawer(),
          bottomNavigationBar: HomeBottomNavigationBar(),
          // floatingActionButton: const FloatingActionButton(onPressed: null),
          // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        ),
      );
    });
  }

  Widget buildHomeContent(BuildContext context, MyBible myBible) {
    // return Container();
    // tz.initializeTimeZones();
    // const bigPicture = BigPictureStyleInformation(
    //   new FilePathAndroidBitmap(attachmentPicturePath),
    //   contentTitle: '<b>COOL Image</b>',
    //   htmlFormatContentTitle: true,
    //   summaryText: 'Bacaan Hari Ini',
    //   htmlFormatSummaryText: true,
    // );
    // const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    //   'id', //Required for Android 8.0 or after
    //   'channel', //Required for Android 8.0 or after
    //   // 'description', //Required for Android 8.0 or after
    //   importance: Importance.max,
    //   priority: Priority.high,
    //   playSound: true,
    //   timeoutAfter: 5000,
    //   styleInformation: DefaultStyleInformation(true, true),
    //   // styleInformation: bigPicture,
    // );
    //
    // const NotificationDetails platformChannelSpecifics =
    //     NotificationDetails(android: androidPlatformChannelSpecifics);
    return Container(
        padding: const EdgeInsets.only(top: 16, bottom: 0),
        child: Column(children: <Widget>[
          DateSelector(date: date, setDate: setDate),
          DailyReadingItem(date: date, myBible: myBible),
          SizedBox(height: 20),
          // Container(
          //     child: ElevatedButton(
          //   onPressed: () async {
          //     await flutterLocalNotificationsPlugin.show(
          //       12345,
          //       "A notification From COOL App",
          //       "This notification was sent using Flutter Local Notification",
          //       platformChannelSpecifics,
          //       payload: 'Simple Notification',
          //     );
          //   },
          //   child: Text('Notification'),
          // )),
          // SizedBox(height: 20),
          // Container(
          //     child: ElevatedButton(
          //   onPressed: () async {
          //     var time = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10));
          //     await flutterLocalNotificationsPlugin.zonedSchedule(
          //       123456,
          //       "A scheduled notification From COOL App",
          //       "This notification will run 10s after the button clicked",
          //       time,
          //       platformChannelSpecifics,
          //       androidAllowWhileIdle: true,
          //       // payload: 'Scheduled Notification',
          //     );
          //   },
          //   child: Text('Scheduled Notification after 10s'),
          // ))
          Rhema(),
        ]));
  }

// Future<String> _downloadAndSaveFile(String url, String fileName) async {
//
//   Directory directory = await getApplicationDocumentsDirectory();
//   String filePath = '${directory.path}/$fileName';
//   var response = await http.get(url);
//   File file = File(filePath);
//   await file.writeAsBytes(response.bodyBytes);
//   return filePath;
// }
}
