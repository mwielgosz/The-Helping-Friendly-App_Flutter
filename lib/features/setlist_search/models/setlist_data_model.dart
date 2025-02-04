// Phish.net Setlist class

import 'dart:convert';

Setlist postFromJson(dynamic response) {
  final dynamic jsonData = json.decode(utf8.decode(response.bodyBytes));
  return Setlist.fromJson(jsonData);
}

String postToJson(Setlist data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

List<Setlist> allPostsFromJson(String str) {
  final jsonData = json.decode(str);
  return List<Setlist>.from(jsonData.map((x) => Setlist.fromJson(x)));
}

String allPostsToJson(List<Setlist> data) {
  final dyn = List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class Setlist {
  bool error;
  String errorMessage;
  List<Song> data;

  Setlist(
      {required this.error, required this.errorMessage, required this.data});

  factory Setlist.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;
    List<Song> data = list.map((i) => Song.fromJson(i)).toList();

    return Setlist(
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

class Song {
  int showId;
  String showDate;
  String permalink;
  String showYear;
  int uniqueId;
  String meta;
  int reviews;
  int exclude;
  String setlistNotes;
  String soundcheck;
  int songId;
  int position;
  int transition;
  String footnote;
  String set;
  int isJam;
  int isReprise;
  int isJamChart;
  String jamChartDescription;
  String trackTime;
  int gap;
  int tourId;
  String tourName;
  String tourWhen;
  String song;
  String nickname;
  String slug;
  int isOriginal;
  int venueId;
  String venue;
  String city;
  String state;
  String country;
  String transMark;
  int artistId;
  String artistSlug;
  String artistName;

  Song({
    required this.showId,
    required this.showDate,
    required this.permalink,
    required this.showYear,
    required this.uniqueId,
    required this.meta,
    required this.reviews,
    required this.exclude,
    required this.setlistNotes,
    required this.soundcheck,
    required this.songId,
    required this.position,
    required this.transition,
    required this.footnote,
    required this.set,
    required this.isJam,
    required this.isReprise,
    required this.isJamChart,
    required this.jamChartDescription,
    required this.trackTime,
    required this.gap,
    required this.tourId,
    required this.tourName,
    required this.tourWhen,
    required this.song,
    required this.nickname,
    required this.slug,
    required this.isOriginal,
    required this.venueId,
    required this.venue,
    required this.city,
    required this.state,
    required this.country,
    required this.transMark,
    required this.artistId,
    required this.artistSlug,
    required this.artistName,
  });

  factory Song.fromJson(Map<String, dynamic> json) => Song(
        showId: json['showid'],
        showDate: json['showdate'],
        permalink: json['permalink'],
        showYear: json['showyear'],
        uniqueId: json['uniqueid'],
        meta: json['meta'],
        reviews: json['reviews'],
        exclude: json['exclude'],
        setlistNotes: json['setlistnotes'],
        soundcheck: json['soundcheck'],
        songId: json['songid'],
        position: json['position'],
        transition: json['transition'],
        footnote: json['footnote'],
        set: json['set'],
        isJam: json['isjam'],
        isReprise: json['isreprise'],
        isJamChart: json['isjamchart'],
        jamChartDescription: json['jamchart_description'],
        trackTime: json['tracktime'],
        gap: json['gap'],
        tourId: json['tourid'],
        tourName: json['tourname'],
        tourWhen: json['tourwhen'],
        song: json['song'],
        nickname: json['nickname'],
        slug: json['slug'],
        isOriginal: json['is_original'],
        venueId: json['venueid'],
        venue: json['venue'],
        city: json['city'],
        state: json['state'],
        country: json['country'],
        transMark: json['trans_mark'],
        artistId: json['artistid'],
        artistSlug: json['artist_slug'],
        artistName: json['artist_name'],
      );

  Map<String, dynamic> toJson() => {
        "showid": showId,
        "showdate": showDate,
        "permalink": permalink,
        "showyear": showYear,
        "uniqueid": uniqueId,
        "meta": meta,
        "reviews": reviews,
        "exclude": exclude,
        "setlistnotes": setlistNotes,
        "soundcheck": soundcheck,
        "songid": songId,
        "position": position,
        "transition": transition,
        "footnote": footnote,
        "set": set,
        "isjam": isJam,
        "isreprise": isReprise,
        "isjamchart": isJamChart,
        "jamchart_description": jamChartDescription,
        "tracktime": trackTime,
        "gap": gap,
        "tourid": tourId,
        "tourname": tourName,
        "tourwhen": tourWhen,
        "song": song,
        "nickname": nickname,
        "slug": slug,
        "is_original": isOriginal,
        "venueid": venueId,
        "venue": venue,
        "city": city,
        "state": state,
        "country": country,
        "trans_mark": transMark,
        "artistid": artistId,
        "artist_slug": artistSlug,
        "artist_name": artistName,
      };
}
