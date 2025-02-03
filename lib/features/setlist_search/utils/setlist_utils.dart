import 'package:html/parser.dart';

import '../models/setlist_data_model.dart';

/*
 * Setlist Utilities for making things easier
 */
class SetlistUtils {
  SetlistUtils._();

  // Organizes Song model data into a List by showId
  static organizeShowById({required List<Song> songs}) {
    List<Song> showList = [];
    List<Song> songsInSet = [];
    int lastShowId = 0;
    int timesRan = 0;

    for (Song song in songs) {
      //log('showID song: ${song.showId} | lastShowId: $lastShowId}');
      timesRan++;
      if (song.showId == lastShowId) {
        songsInSet.add(song);
      } else {
        lastShowId = song.showId;
        showList.add(song);
        songsInSet.clear();
      }
      //log('organizeByShowId $timesRan. Number of shows: ${showList.length.toString()} | Songs in set: ${songsInSet.length.toString()}');
    }

    if (timesRan == songsInSet.length) {
      showList.add(songs.first);
    }
    //log('organizeByShowId $timesRan. Number of shows: ${showList.length.toString()} | Songs in set: ${songsInSet.length.toString()}');

    return showList;
  }

  // Returns a List of Songs determined by the showId
  static getSongsByShowId({required List<Song> set, required int showId}) {
    List<Song> showSongs = [];
    //log('getSongsByShowId. set length: ${set.length}');

    for (Song song in set) {
      if (song.showId == showId) {
        //log('getSongsByShowId. showId: $showId | song name: ${song.song}');
        showSongs.add(song);
      }
    }
    //log('getSongsByShowId. showSongs length: ${showSongs.length}');
    return showSongs;
  }

  // Organizes Song model data into a Map that can be used to display Setlist information
  static organizeSet({required List<Song> set, required int showId}) {
    // Sort set list by unique ID so they appear in correct order
    set.sort((a, b) => a.uniqueId.compareTo(b.uniqueId));
    Map<String, String> setList = {};
    int footnoteCount = 0;
    String lastSetName = 'Set 1: ';
    for (Song song in set) {
      if (song.showId == showId) {
        String setStart = 'Set ${song.set}: ';

        if (song.set == 'e') {
          setStart = 'Encore: ';
        } else if (song.footnote != '' && song.song != song.footnote) {
          footnoteCount++;
        }
        if (lastSetName != setStart) setStart = '\n${setStart.toString()}';
        if (setList[setStart] == null) {
          if (song.footnote != '' && song.song != song.footnote) {
            setList[setStart] = '${song.song}[$footnoteCount]${song.transMark}';
          } else {
            setList[setStart] = '${song.song}${song.transMark}';
          }
        } else {
          if (song.footnote != '' && song.song != song.footnote) {
            setList[setStart] =
                '${setList[setStart].toString()}${song.song}[$footnoteCount] ${song.transMark}';
            setList['footnote_count_$footnoteCount'] = '\n[$footnoteCount]';
            setList['footnote_$footnoteCount'] = ' ${song.footnote}';
          } else {
            setList[setStart] =
                '${setList[setStart].toString()}${song.song}${song.transMark}';
          }
        }
        lastSetName = setStart;
      }
    }
    //log('organizeSet. setList length AFTER: ${setList.length}');
    return setList;
  }

  // Removed last Setlist from List<Song> as it will be incomplete with data due to API limitations
  static removeLastSetlist({required List<Song> songs}) {
    List<Song> songsToRemove = [];
    String lastDate = songs.last.showDate;
    for (var element in songs) {
      if (element.showDate == lastDate) {
        songsToRemove.add(element);
      }
    }

    songs.removeWhere((element) => songsToRemove.contains(element));
    return songs;
  }

  // Parses HTML to basic string removing HTML tags found in some JSON returns
  static parseHtmlToString({required String htmlStr}) {
    htmlStr = htmlStr.replaceAll('&nbsp;', ' ');
    htmlStr = htmlStr.replaceAll(RegExp('<(.*?)>'), '');
    final document = parse(htmlStr);
    String? parsedString = parse(document.body?.text).documentElement?.text;
    parsedString = parsedString?.trim().replaceAll(RegExp(r'(\n){3,}'), "\n\n");
    return parsedString;
  }
}
