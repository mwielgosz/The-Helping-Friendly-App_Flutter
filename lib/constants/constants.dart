/* Constant variables */

import 'package:flutter/material.dart';
import 'package:material_color_gen/material_color_gen.dart';
import 'package:the_helping_friendly_app/constants/private_constants.dart';

// Custom colors Constants
// Color code: HEX (ffffff) and first two characters (FF) are alpha values (transparency)
const Color primaryAppBarColor = Color(0xff5c2040);
final MaterialColor primaryAppBarMaterialColor =
    primaryAppBarColor.toMaterialColor();

// URL constants
const urlAllShows =
    "https://api.phish.net/v5/shows.json?order_by=showdate&direction=desc&limit=100&apikey=&apikey=$phishNetApiKey";

const urlSetlistAll =
    'https://api.phish.net/v5/setlists.json?order_by=showdate&limit=500&direction=desc&apikey=$phishNetApiKey';
const urlSetlistSearchStart = 'https://api.phish.net/v5/setlists/showdate/';
const urlSetlistIdSearchStart = 'https://api.phish.net/v5/setlists/showid/';
const urlSetlistSearchEnd = '.json?apikey=$phishNetApiKey';
