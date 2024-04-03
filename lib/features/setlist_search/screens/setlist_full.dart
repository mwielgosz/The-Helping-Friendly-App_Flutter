import 'package:flutter/material.dart';
import 'package:the_helping_friendly_app/features/setlist_search/models/setlist_data_model.dart';

import '../../../constants/constants.dart';
import '../widgets/setlist_card_widget.dart';

/*
 * Show Card Widget
 * Displays data gathered from Phish.net API and displays it in a Card
 */

class SetlistFullPage extends StatelessWidget {
  final List<Song> organizedSet;
  final int index;
  final List<Song> fullResults;
  final bool displayFootnotes;

  const SetlistFullPage(
      {super.key,
      required this.organizedSet,
      required this.index,
      required this.fullResults,
      required this.displayFootnotes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Setlist: ${organizedSet.first.showDate}'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 22),
        backgroundColor: primaryAppBarMaterialColor,
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            SetlistCardWidget(
              set: organizedSet,
              index: index,
              //showId: set[index].showId,
              fullResults: fullResults,
              displayFootnotes: true,
            ),
          ],
        ),
      ),
    );
  }
}
