// Phish.net AllShows Model class

import 'dart:convert';

AllShows postFromJson(String str) {
  final jsonData = json.decode(str);
  return AllShows.fromJson(jsonData);
}

String postToJson(AllShows data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

List<AllShows> allPostsFromJson(String str) {
  final jsonData = json.decode(str);
  return List<AllShows>.from(jsonData.map((x) => AllShows.fromJson(x)));
}

String allPostsToJson(List<AllShows> data) {
  final dyn = List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class AllShows {
  bool error;
  String errorMessage;
  List<Show> data;

  AllShows(
      {required this.error, required this.errorMessage, required this.data});

  factory AllShows.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;
    List<Show> data = list.map((i) => Show.fromJson(i)).toList();

    return AllShows(
        error: parsedJson['error'],
        errorMessage: parsedJson['error_message'],
        data: data);
  }

  Map<String, dynamic> toJson() => {
        "error": error,
        "error_message": errorMessage,
        "data": data,
      };
}

class Show {
  final int showID;
  final String showYear;
  final int showMonth;
  final int showDay;
  final String showDate;
  final String permalink;
  final int excludeFromStats;
  final int venueId;
  final String setlistNotes;
  final String venue;
  final String city;
  final String state;
  final String country;
  final int artistId;
  final String artistName;
  final int tourId;
  final String tourName;
  final String createdAt;
  final String updatedAt;

  Show(
      {required this.showID,
      required this.showYear,
      required this.showMonth,
      required this.showDay,
      required this.showDate,
      required this.permalink,
      required this.excludeFromStats,
      required this.venueId,
      required this.setlistNotes,
      required this.venue,
      required this.city,
      required this.state,
      required this.country,
      required this.artistId,
      required this.artistName,
      required this.tourId,
      required this.tourName,
      required this.createdAt,
      required this.updatedAt});

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      showID: json['showid'] as int,
      showYear: json['showyear'] as String,
      showMonth: json['showmonth'] as int,
      showDay: json['showday'] as int,
      showDate: json['showdate'] as String,
      permalink: json['permalink'] as String,
      excludeFromStats: json['exclude_from_stats'] as int,
      venueId: json['venueid'] as int,
      setlistNotes: json['setlist_notes'] as String,
      venue: json['venue'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
      artistId: json['artistid'] as int,
      artistName: json['artist_name'] as String,
      tourId: json['tourid'] as int,
      tourName: json['tour_name'] as String,
      createdAt: json['created_at']! as String,
      updatedAt: json['updated_at']! as String,
    );
  }
}
