import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:the_helping_friendly_app/features/setlist_search/services/setlist_service.dart';
import 'package:the_helping_friendly_app/features/setlist_search/widgets/setlist_card_widget.dart';

import '../../../constants/constants.dart';
import '../../setlist_search/models/setlist_data_model.dart';
import '../../setlist_search/utils/setlist_utils.dart';

/*
 * Single Show Detail PAge
 * Displays single show from phish.net
 */

class SingleShowDetailsPage extends StatefulWidget {
  const SingleShowDetailsPage(
      {super.key, required this.label, required this.showId});
  final String label;
  final String showId;

  @override
  State<StatefulWidget> createState() => SingleShowDetailsPageState();
}

class SingleShowDetailsPageState extends State<SingleShowDetailsPage> {
  ScrollController _controller = ScrollController();
  List<Song> shows = [];

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener); //the listener for up and down.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Date: ${widget.label}'),
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 22),
          backgroundColor: primaryAppBarMaterialColor,
        ),
        body: FutureBuilder<Setlist>(
            future: getSetlistByShowId(widget.showId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData && snapshot.data != null) {
                  //return SongList(songs: snapshot.data!.data);
                  shows = snapshot.data?.data as List<Song>;
                  //log('List<Song> songs data: $songs');
                  log('singleShowDetails. Set length: ${shows.length}');

                  //List<Song> organizedSet = List.empty();
                  if (shows.isEmpty) {
                    return const Center(
                      child: //Column(children: <Widget>[
                          Text(
                        'This show has in the future, so no data is available yet!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  //} else if (set.length > 1) {
                  // Remove last setlist as it will be incomplete if displaying more than one show
                  if (shows.first.showId != shows.last.showId) {
                    shows = SetlistUtils.removeLastSetlist(songs: shows);
                  }

                  // Organize all returned data into presentable form
                  List<Song> organizedSet =
                      SetlistUtils.organizeShowById(songs: shows);
                  //}
                  log('List<Song> set data length: ${shows.length}');

                  return SingleChildScrollView(
                    child: Row(children: [
                      SetlistCardWidget(
                          set: organizedSet,
                          index: 0,
                          fullResults: shows,
                          displayFootnotes: true),
                    ]),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: //Column(children: <Widget>[
                        Text('An error has occurred!'),
                  );
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
              return Center(
                child: Column(
                  children: <Widget>[
                    const Text('Something is missing!'),
                    Text('Error: ${snapshot.error.toString()}'),
                  ],
                ),
              );
            }));
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        //you can do anything here
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        //you can do anything here
      });
    }
  }
}
