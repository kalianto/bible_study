import 'dart:async';
import 'package:intl/intl.dart';
import '../database.dart';

class DailyReading {
  DateTime date;
  int id;
  int start;
  int end;
  int groupId;
  int order;
  int _dateId;

  DailyReading(this.date, this.id, this.start, this.end, this.groupId, this.order);

  final dbProvider = DatabaseProvider();

  DailyReading.daily(DateTime date) {
    this.date = date ?? DateTime.now();
    this._dateId = int.parse(DateFormat('dm').format(this.date));
    this.getDailyReading(this._dateId);
  }

  Future<DailyReading> getDailyReading(int date) async {
    // List<Map<String, dynamic>> result = await dbProvider.query('t_asv');
    var result = await dbProvider.countTable();
    print('result $result');
  }
}
