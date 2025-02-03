import 'package:flutter/material.dart';
import 'package:the_helping_friendly_app/features/all_shows/screens/all_shows.dart';
import 'package:the_helping_friendly_app/features/setlist_search/screens/setlist_search.dart';

import 'constants/constants.dart';

void main() => runApp(const TheHelpingFriendlyApp());

class TheHelpingFriendlyApp extends StatelessWidget {
  const TheHelpingFriendlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //appBarTheme: appBarTheme(this)
        primarySwatch: primaryAppBarMaterialColor,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryAppBarMaterialColor)
            .copyWith(surface: Colors.black),
      ),
      home: const TheHelpingFriendlyAppHomePage(
        title: 'The Helping Friendly App',
      ),
    );
  }
}

class TheHelpingFriendlyAppHomePage extends StatefulWidget {
  const TheHelpingFriendlyAppHomePage({super.key, required this.title});

  final String title;

  @override
  State<TheHelpingFriendlyAppHomePage> createState() =>
      _TheHelpingFriendlyAppHomePageState();
}

class _TheHelpingFriendlyAppHomePageState
    extends State<TheHelpingFriendlyAppHomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    //final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: <Widget>[
        const AllShowsPage(label: 'All Shows'),
        const SetlistSearchPage(label: 'Setlist Search'),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
            (Set<WidgetState> states) => states.contains(WidgetState.selected)
                ? const TextStyle(color: primaryAppBarColor)
                : const TextStyle(color: Colors.white),
          ),
        ),
        child: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          backgroundColor: Colors.black,
          indicatorColor: primaryAppBarMaterialColor,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home_outlined, color: Colors.white),
              icon: Icon(Icons.home_sharp, color: Colors.white),
              label: 'All Shows',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.search_outlined, color: Colors.white),
              icon: Icon(Icons.search_sharp, color: Colors.white),
              label: 'Setlist Search',
            ),
          ],
        ),
      ),
    );
  }
}
