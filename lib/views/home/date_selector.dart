import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../app_theme.dart';
import '../../helpers/date_helper.dart' as DateHelper;

class DateSelector extends StatefulWidget {
  DateSelector({Key key, this.date, this.setDate}) : super(key: key);

  final DateTime date;
  final setDate;

  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime today;

  void initState() {
    super.initState();
    today = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
        IconButton(
          icon: FaIcon(FontAwesomeIcons.angleLeft),
          onPressed: previousDay,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextButton(
            child: Text(DateHelper.formatDate(today),
                style:
                    TextStyle(color: AppTheme.darkGrey, fontSize: 20, fontWeight: FontWeight.w600)),
            onPressed: () => pickDate(context),
            style: TextButton.styleFrom(
              enableFeedback: true,
              primary: AppTheme.lightGreen,
              shadowColor: AppTheme.lightGreen,
              onSurface: AppTheme.lightGreen,
            ),
          ),
        ),
        IconButton(
          icon: FaIcon(FontAwesomeIcons.angleRight),
          onPressed: nextDay,
        ),
      ]),
    );
  }

  void previousDay() {
    setState(() {
      today = today.subtract(const Duration(days: 1));
      widget.setDate(today);
    });
  }

  void nextDay() {
    setState(() {
      today = today.add(const Duration(days: 1));
      widget.setDate(today);
    });
  }

  void pickDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: today.subtract(const Duration(days: 365)),
      lastDate: today.add(const Duration(days: 365)),
    );
    if (picked != null && picked != today) {
      setState(() {
        today = picked;
        widget.setDate(today);
      });
    }
  }
}
