import 'package:flutter/material.dart';
import 'package:the_helping_friendly_app/features/all_shows/models/all_shows_model.dart';
import 'package:the_helping_friendly_app/features/all_shows/screens/single_show_details.dart';
import 'package:the_helping_friendly_app/features/all_shows/services/all_shows_service.dart';
import 'package:the_helping_friendly_app/features/all_shows/widgets/show_card_widget.dart';

import '../../../constants/constants.dart';

/*
 * All Shows PAge
 * Displays all shows from phish.net
 */

class AllShowsPage extends StatefulWidget {
  const AllShowsPage({super.key, required this.label});
  final String label;

  @override
  State<StatefulWidget> createState() => AllShowsPageState();
}

class AllShowsPageState extends State<AllShowsPage> {
  ScrollController _controller = ScrollController();
  List<Show> shows = [];

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
          title: const Text('All Shows'),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 22),
          backgroundColor: primaryAppBarMaterialColor,
        ),
        body: FutureBuilder<AllShows>(
            future: getAllShows(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData && snapshot.data != null) {
                  //return SongList(songs: snapshot.data!.data);
                  shows = snapshot.data?.data as List<Show>;
                  //log('List<Song> songs data: $songs');
                  return ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      ListView.builder(
                        controller: _controller, //new line
                        itemCount: shows.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SingleShowDetailsPage(
                                      label: shows[index].showDate,
                                      showId: shows[index].showID),
                                  // Pass the arguments as part of the RouteSettings. The
                                  // DetailScreen reads the arguments from these settings.
                                  settings: RouteSettings(
                                    arguments: shows[index],
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ShowCardWidget(show: shows[index]) //),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  );

                  //const Column(children: <Widget>[
                  //SetlistCardWidget(set: shows)
                  //],
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
