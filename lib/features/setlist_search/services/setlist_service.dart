import 'dart:async';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:the_helping_friendly_app/constants/constants.dart';

import '../models/setlist_data_model.dart';

// Future to retrieve JSON setlist data from phish.net API and parse it into the Setlist model
Future<Setlist> getSetlistByDate(String searchDate) async {
  var urlSetlistSearch = '';
  if (searchDate == '') {
    urlSetlistSearch = urlSetlistAll;
  } else {
    urlSetlistSearch = urlSetlistSearchStart + searchDate + urlSetlistSearchEnd;
  }
  log(urlSetlistSearch);
  final urlToUri = Uri.parse(urlSetlistSearch);
  final response = await http.get(urlToUri);
  //log(response.body);
  return postFromJson(response.body);
}

// Future to retrieve JSON setlist data from phish.net API and parse it into the Setlist model
Future<Setlist> getSetlistByShowId(String showId) async {
  var urlSetlistSearch = '';
  if (showId == '') {
    urlSetlistSearch = urlSetlistAll;
  } else {
    urlSetlistSearch = urlSetlistIdSearchStart + showId + urlSetlistSearchEnd;
  }
  log(urlSetlistSearch);
  final urlToUri = Uri.parse(urlSetlistSearch);
  final response = await http.get(urlToUri);
  //log(response.body);
  return postFromJson(response.body);
}
