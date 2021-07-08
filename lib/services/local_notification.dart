import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNofitication {
  static LocalNofitication _localNotification;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  LocalNofitication._createInstance();

  factory LocalNofitication() {
    if (_localNotification == null) {
      _localNotification = LocalNofitication._createInstance();
      //_localNotification._initialize();
    }
    return _localNotification;
  }
}
