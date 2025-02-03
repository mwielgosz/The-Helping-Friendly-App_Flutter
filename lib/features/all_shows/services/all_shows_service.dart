import 'dart:async';

import 'package:http/http.dart' as http;

import '../../../../constants/constants.dart';
import '../models/all_shows_model.dart';

// Future to retrieve JSON show data from phish.net API and parse it into the AllShows model
Future<AllShows> getAllShows() async {
  //var urlSetlistSearch = urlAllShows;
  //log('Show Setlists: $urlAllShows');
  final urlToUri = Uri.parse(urlAllShows);
  final response = await http.get(urlToUri);
  //log(response.body);
  return postFromJson(response.body);
}
