import 'package:flutter/material.dart';

class BibleContent extends StatefulWidget {
  @override
  _BibleContentState createState() => _BibleContentState();
}

class _BibleContentState extends State<BibleContent> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 60),
      child: _buildReadingView(context),
    );
  }

  Widget _buildReadingView(BuildContext context) {
    return Container();
  }
}
