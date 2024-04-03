import 'package:flutter/material.dart';
import 'package:the_helping_friendly_app/features/setlist_search/screens/setlist_full.dart';
import 'package:the_helping_friendly_app/features/setlist_search/widgets/setlist_card_widget.dart';

import '../../../constants/constants.dart';
import '../models/setlist_data_model.dart';
import '../services/setlist_service.dart';
import '../utils/setlist_utils.dart';

/*
 * Setlist Search Page
 * Allows for date search of Phish Setlists
 */

class SetlistSearchPage extends StatefulWidget {
  final String label;

  const SetlistSearchPage({super.key, required this.label});

  @override
  State<StatefulWidget> createState() => SetlistSearchPageState();
}

class SetlistSearchPageState extends State<SetlistSearchPage> {
  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener); //the listener for up and down.
    super.initState();
  }

  Widget _searchTextField() {
    final RegExp dateRegex = RegExp('\\d{4}\\-\\d{2}\\-\\d{2}');
    return TextField(
      autofocus: true,
      autocorrect: false,
      style: const TextStyle(
          fontSize: 18, color: Colors.black, backgroundColor: Colors.white),
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(32),
        ),
        hintStyle: const TextStyle(fontSize: 18, color: Colors.grey),
        hintText: 'Setlist search (2023-12-31)',
        hintFadeDuration: const Duration(milliseconds: 250),
        //suffixIcon: const Icon(Icons.search),
        //suffixIconColor: primaryAppBarColor,
        contentPadding: const EdgeInsets.all(12),
      ),
      onSubmitted: (String dateInput) {
        dateInput.replaceAll('/', '-');
        //log('_searchTextField date-check: ${dateInput.contains(dateRegex)}');
        if (dateInput.contains(dateRegex)) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Searching for $dateInput setlist'),
          ));
          setState(() {
            _searchMode = false;
            _searchDate = dateInput;
          });
        } else if (dateInput == '') {
          setState(() {
            _searchMode = false;
            _searchDate = '';
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Bad date format. Use: YYYY-MM-DD'),
          ));
          _searchDate = '';
        }
      },
    );
  }

  ScrollController _controller = ScrollController();
  bool _searchMode = false;
  String _searchDate = '';
  List<Song> set = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: !_searchMode ? Text(widget.label) : _searchTextField(),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 22),
          backgroundColor: primaryAppBarMaterialColor,
          actions: !_searchMode
              ? [
                  IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _searchMode = true;
                        });
                      })
                ]
              : [
                  IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _searchMode = false;
                          _searchDate = '';
                        });
                      })
                ]),
      body: FutureBuilder<Setlist>(
        future: getSetlistByDate(_searchDate),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              set = snapshot.data?.data as List<Song>;

              // Display Text stating error concerning input date
              if (set.isEmpty) {
                return const Center(
                  child: //Column(children: <Widget>[
                      Text(
                    'An error has occurred!\nPlease check the search date & try again!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              // Remove last setlist as it will be incomplete if displaying more than one show
              if (set.first.showId != set.last.showId) {
                set = SetlistUtils.removeLastSetlist(songs: set);
              }

              // Organize all returned data into presentable form
              List<Song> organizedSet =
                  SetlistUtils.organizeShowById(songs: set);

              //log('List<Song> set data length: ${set.length}');
              return ListView(
                scrollDirection: Axis.vertical,
                children: [
                  ListView.builder(
                    controller: _controller, //new line
                    itemCount: organizedSet.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        //onTap: _fullSetlistCard(
                        //    organizedSet, index, fullResults, true),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SetlistFullPage(
                                organizedSet: organizedSet,
                                index: index,
                                fullResults: set,
                                displayFootnotes: true,
                              ),
                              // Pass the arguments as part of the RouteSettings. The
                              // DetailScreen reads the arguments from these settings.
                              settings: RouteSettings(
                                arguments: set[index],
                              ),
                            ),
                          );
                        },
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SetlistCardWidget(
                                set: organizedSet,
                                index: index,
                                fullResults: set,
                                displayFootnotes: false,
                              ),
                            ]),
                      );
                    },
                  ),
                ],
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
        },
      ),
    );
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
