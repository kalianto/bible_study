// import 'package:flutter/material.dart';
// import 'package:scroll_to_index/scroll_to_index.dart';
//
// import '../../app_theme.dart';
// import '../../app_config.dart';
// import '../../services/bible_view.dart';
// import '../../models/bible_view.dart';
//
// class BibleContent extends StatefulWidget {
//   @override
//   _BibleContentState createState() => _BibleContentState();
// }
//
// class _BibleContentState extends State<BibleContent> {
//   AutoScrollController scrollController;
//
//   @override
//   void initState() {
//     super.initState();
//     scrollController = AutoScrollController(
//         viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
//         axis: Axis.vertical);
//
//     WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToIndex(context));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(left: 10, right: 10, top: 60),
//       child: _buildReadingView(context),
//     );
//   }
//
//   Widget _buildReadingView(BuildContext context) {
//     return Container();
//   }
//
//   Future<List<BibleView>> getBookContent(int bibleVersion) async {
//     var dbClient = BibleViewProvider();
//     List<BibleView> bibleViewList = await dbClient.getBibleView(widget.readingItem, bibleVersion);
//     return bibleViewList;
//   }
//
//   Widget _getRowOnly(int index, BibleView data) => InkWell(
//     onTap: () {
//       setState(() {
//         if (isSelected(data.id)) {
//           selectedList.removeWhere((item) => item.id == data.id);
//         } else {
//           selectedList.add(data);
//         }
//       });
//     },
//     child: Container(
//       padding: const EdgeInsets.all(8),
//       decoration: isSelected(data.id)
//           ? BoxDecoration(
//         color: AppTheme.darkGrey.withOpacity(0.5),
//       )
//           : BoxDecoration(),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Container(
//               padding: const EdgeInsets.only(left: 0, right: 6),
//               child: Text(
//                 data.bookVerse.toString(),
//                 style: AppTheme.body2,
//               )),
//           Expanded(child: _getBibleText(data)),
//         ],
//       ),
//     ),
//   );
//
//   Widget _getRowWithHeading(int index, BibleView data) => Column(children: <Widget>[
//     Container(
//         padding: const EdgeInsets.symmetric(vertical: 20),
//         child:
//         Text(data.bookName + ' ' + data.bookChapter.toString(), style: AppTheme.headline5)),
//     _getRowOnly(index, data),
//   ]);
//
//   Widget _getBibleText(BibleView data) {
//     if (data.bibleCode.toLowerCase() == 'web') {
//       List<String> matchedText = [];
//       String text = data.bookText.replaceAllMapped(new RegExp(r'({.*?})'), (match) {
//         matchedText.add(match.group(0));
//         return '*';
//       });
//       if (matchedText.length > 0) {
//         List<String> splitText = text.split('*');
//
//         if ((splitText.length - 1) == matchedText.length) {
//           List<Widget> textSpan = [];
//           for (var i = 0; i < splitText.length; i++) {
//             textSpan.add(Text(splitText[i], style: AppTheme.body1));
//             if (i < matchedText.length) {
//               textSpan.add(InkWell(
//                   onTap: () {
//                     _showBibleTextDialog(matchedText[i]);
//                   },
//                   child: Text('*',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         letterSpacing: 1,
//                       ))));
//             }
//           }
//           return Wrap(direction: Axis.horizontal, children: textSpan);
//           // return Text(data.bookText, style: AppTheme.body1);
//         } else {
//           return Text(data.bookText, style: AppTheme.body1);
//         }
//       } else {
//         return Text(data.bookText, style: AppTheme.body1);
//       }
//     } else {
//       return Text(data.bookText, style: AppTheme.body1);
//     }
//   }
//
//   Future<void> _showBibleTextDialog(String refText) async {
//     String text = refText.replaceAll(new RegExp(r'{|}'), '');
//     AlertDialog dialog = AlertDialog(
//       title: Text('Reference'),
//       content: SingleChildScrollView(
//           child: ListBody(
//             children: <Widget>[Text(text, style: AppTheme.body1)],
//           )),
//       actions: <Widget>[
//         TextButton(
//             child: Text('Close'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             }),
//       ],
//     );
//
//     Future futureValue = showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return dialog;
//         });
//
//     return futureValue;
//   }
//
//   bool isSelected(int id) {
//     if (selectedList.isEmpty) return false;
//     return selectedList.where((item) => item.id == id).length == 1;
//   }
//
//   Future _scrollToIndex(context) async {
//     int index = widget.readingItem.sVerse - 1;
//     await scrollController.scrollToIndex(index, preferPosition: AutoScrollPosition.begin);
//     scrollController.highlight(index);
//   }
// }
