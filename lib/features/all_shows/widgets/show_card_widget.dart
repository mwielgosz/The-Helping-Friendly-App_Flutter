import 'package:flutter/material.dart';
import 'package:the_helping_friendly_app/features/all_shows/models/all_shows_model.dart';

import '../../setlist_search/utils/setlist_utils.dart';

/*
 * Show Card Widget
 * Displays data gathered from Phish.net API and displays it in a Card
 */

class ShowCardWidget extends StatelessWidget {
  final Show show;

  const ShowCardWidget({super.key, required this.show});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Card(
        elevation: 0.0,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          //height: 250,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.black87,
            border: Border.all(
              color: Colors.transparent,
            ),
          ),

          child: Column(
            children: <Widget>[
              // Row(children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text(
                  '${show.artistName} ${show.showDate}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    show.venue,
                    style: const TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                  if (show.country == 'USA') ...{
                    Text(
                      '${show.city}, ${show.state}',
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                  } else ...{
                    Text(
                      '${show.city}, ${show.country}',
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                  },
                ],
              ),
              if (show.setlistNotes != '') ...{
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 8.0),
                  child: RichText(
                    text: TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: const TextStyle(
                        fontSize: 14.0,
                        height: 1.5,
                        color: Colors.white,
                      ),
                      children: <TextSpan>[
                        const TextSpan(
                            text: 'Notes:',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                '\n${SetlistUtils.parseHtmlToString(html: show.setlistNotes)}',
                            style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}
