// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNofitication {
  static LocalNofitication _localNotification = LocalNofitication._createInstance();
  // final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  LocalNofitication._createInstance();

  factory LocalNofitication() {
    // _localNotification is already initialized, so no need to check for null
    //_localNotification._initialize();
    return _localNotification;
  }
}
