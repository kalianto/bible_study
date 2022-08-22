import 'package:flutter/material.dart';

import '../../app_theme.dart';
import '../../helpers/date_helper.dart' as DateHelper;
import '../../models/add_rhema_arguments.dart';
import '../../modules/rhema.dart';
import '../../views/common/simpleDialog.dart';

class AddRhemaPage extends StatefulWidget {
  AddRhemaPage({Key key, this.arguments}) : super(key: key);

  final AddRhemaArguments arguments;

  @override
  _AddRhemaPageState createState() => _AddRhemaPageState();
}

class _AddRhemaPageState extends State<AddRhemaPage> {
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  final _rhemaController = TextEditingController();

  bool selected = false;
  DateTime date;

  @override
  void initState() {
    super.initState();
    _loadRhemaData();
  }

  @override
  void dispose() {
    super.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    _rhemaController.dispose();
  }

  void setDate(DateTime newDate) {
    setState(() {
      date = newDate;
    });
  }

  void _loadRhemaData() {
    setState(() {
      date = widget.arguments.date;
      _messageController.text = widget.arguments.summary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Add Rhema'),
              backgroundColor: AppTheme.blueText,
            ),
            body: SingleChildScrollView(
              child: _buildForm(context),
            )));
  }

  Widget _buildForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(children: <Widget>[
        Align(
          child: Text(
            'Click on the date to change it.\n'
            'Enter your Rhema below. '
            'Verses are not editable',
            style: AppTheme.body1,
          ),
          alignment: Alignment.centerLeft,
        ),
        SizedBox(height: 20),
        Container(
            child: Row(
          children: <Widget>[
            Expanded(
                child: Align(
              child: Text('Date', style: AppTheme.headline6),
              alignment: Alignment.centerLeft,
            )),
            Container(width: 10),
            Expanded(
              child: TextButton(
                child: Text(DateHelper.formatDate(date),
                    style: TextStyle(
                        color: AppTheme.darkGrey, fontSize: 20, fontWeight: FontWeight.w600)),
                onPressed: () => pickDate(context),
                style: TextButton.styleFrom(
                  enableFeedback: true,
                  primary: AppTheme.lightGreen,
                  shadowColor: AppTheme.lightGreen,
                  onSurface: AppTheme.lightGreen,
                ),
              ),
            ),
          ],
        )),
        SizedBox(height: 20),
        Align(
          child: Text('Verses', style: AppTheme.headline6),
          alignment: Alignment.centerLeft,
        ),
        SizedBox(height: 10),
        TextField(
          controller: _messageController,
          decoration: InputDecoration(
            enabledBorder: AppTheme.inputBorderless,
            focusedBorder: AppTheme.inputBorderless,
            filled: true,
            fillColor: AppTheme.notWhite,
            // icon: Icon(Icons.person),
          ),
          maxLines: 5,
          readOnly: true,
        ),
        SizedBox(height: 20),
        Align(
          child: Text('Rhema', style: AppTheme.headline6),
          alignment: Alignment.centerLeft,
        ),
        SizedBox(height: 10),
        TextField(
          controller: _rhemaController,
          decoration: InputDecoration(
            enabledBorder: AppTheme.inputBorderless,
            focusedBorder: AppTheme.inputBorderless,
            filled: true,
            fillColor: AppTheme.notWhite,
            // icon: Icon(Icons.person),
          ),
          maxLines: 8,
        ),
        SizedBox(height: 20),
        Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: () {
                showSimpleDialog(context, 'Adding Rhema', 'Please wait....');

                addRhema(date, _rhemaController.text, widget.arguments.rhemaVerses).then((rhema) {
                  if (rhema.id != null) {
                    Navigator.of(context).pop();
                  }
                  Navigator.of(context).pop();
                });
              },
              child: Text('Add'),
            ))
      ]),
    );
  }

  void pickDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: date.subtract(const Duration(days: 365)),
      lastDate: date.add(const Duration(days: 365)),
    );
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
        setDate(date);
      });
    }
  }
}
