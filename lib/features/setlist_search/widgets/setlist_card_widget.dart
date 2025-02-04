import 'package:flutter/material.dart';
import 'package:the_helping_friendly_app/features/setlist_search/utils/setlist_utils.dart';

import '../models/setlist_data_model.dart';

/*
 * Setlist Card Widget
 * Displays data gathered from Phish.net API and displays it in a Card
 */

class SetlistCardWidget extends StatelessWidget {
  final List<Song> set;
  final int index;
  final List<Song> fullResults;
  final bool displayFootnotes;

  const SetlistCardWidget(
      {super.key,
      required this.set,
      required this.index,
      required this.fullResults,
      required this.displayFootnotes});

  @override
  Widget build(BuildContext context) {
    Song show = set[index];
    Map<String, String> setList =
        SetlistUtils.organizeSet(set: fullResults, showId: set[index].showId);
    //log('setlistcardwidget. set length (number of cards): ${set.length}');
    //log('setlistCardWidget. show ID: ${show.showId} | set index showId: ${set[index].showId}');
    //log('setlistCardWidget. show date: ${show.showDate}');

    return Flexible(
        child: Card(
      elevation: 4.0,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        //height: 250,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.black87,
          border: Border.all(
            color: Colors.white,
          ),
        ),

        child: Column(
          children: <Widget>[
            // Row(children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${show.artistName} ${show.showDate}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        show.venue,
                        style:
                            const TextStyle(fontSize: 16.0, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        if (show.country == 'USA') ...{
                          Text(
                            '${show.city}, ${show.state}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.grey),
                          ),
                        } else ...{
                          Text(
                            '${show.city}, ${show.country}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.grey),
                          ),
                        },
                      ],
                    ),
                  ),
                )
              ],
            ),

            // Add soundcheck
            _soundcheckWidget(set[index]),
            // Add setlist
            _setlistWidget(setList, displayFootnotes),
            // Add footnotes
            _setlistFootnoteWidget(setList, displayFootnotes),
            // Add set notes
            _setlistNotesWidget(set[index], displayFootnotes),
          ],
        ),
      ),
    ));
  }
}

_soundcheckWidget(Song song) {
  if (song.soundcheck.isEmpty) {
    // Return empty container if no soundcheck
    return Container();
  }
  return Container(
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.only(left: 8.0),
    child: RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 14.0,
          height: 1.5,
          color: Colors.white,
        ),
        children: <TextSpan>[
          const TextSpan(
              text: "Soundcheck: ",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          TextSpan(
              text: song.soundcheck,
              style: const TextStyle(color: Colors.white)),
        ],
      ),
    ),
  );
}

_setlistWidget(Map<String, String> setList, bool displayFootnotes) {
  return Container(
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.only(left: 8.0),
    child: RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 14.0,
          height: 1.5,
          color: Colors.white,
        ),
        children: <TextSpan>[
          for (String key in setList.keys) ...{
            if (!key.contains('footnote')) ...{
              TextSpan(
                  text: key,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              if (displayFootnotes) ...{
                TextSpan(
                    text: '${setList[key]}',
                    style: const TextStyle(color: Colors.white)),
              } else ...{
                TextSpan(
                    text:
                        '${setList[key]}'.replaceAll(RegExp('\\[\\d+\\]'), ''),
                    style: const TextStyle(color: Colors.white)),
              }
            },
          }
        ],
      ),
    ),
  );
}

_setlistFootnoteWidget(Map<String, String> setList, bool displayFootnotes) {
  // Return empty container if no footnotes
  if (setList.isEmpty ||
      !setList.keys.contains('footnote_1') ||
      !displayFootnotes) {
    return Container();
  }
  if (setList.keys.contains('footnote_1')) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 8.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 14.0,
            height: 1.5,
            color: Colors.white,
          ),
          children: <TextSpan>[
            for (String key in setList.keys) ...{
              if (key.contains('footnote_count') && key != '') ...{
                TextSpan(
                    text: '${setList[key]}',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              },
              if (!key.contains('footnote_count') &&
                  key.contains('footnote') &&
                  key != '') ...{
                TextSpan(
                    text: '${setList[key]}',
                    style: const TextStyle(color: Colors.white)),
              }
            }
          ],
        ),
      ),
    );
  }
}

_setlistNotesWidget(Song show, bool displayFootnotes) {
  if (!displayFootnotes) {
    return Container();
  }
  return Container(
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.only(left: 8.0),
    child: RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 14.0,
          height: 1.5,
          color: Colors.white,
        ),
        children: <TextSpan>[
          const TextSpan(
              text: '\nNotes:',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          TextSpan(
              text:
                  '\n${SetlistUtils.parseHtmlToString(htmlStr: show.setlistNotes)}',
              style: const TextStyle(color: Colors.white)),
        ],
      ),
    ),
  );
}
