import 'package:binario_m/pages/tabs/favourites.dart';
import 'package:binario_m/pages/tabs/news.dart';
import 'package:binario_m/pages/tabs/station.dart';
import 'package:binario_m/pages/tabs/trains.dart';
import 'package:binario_m/providers/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> tabs = [
    const TrainsTab(),
    const StationTab(),
    const FavouritesTab(),
    const NewsTab()
  ];
  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Binario M"),
        actions: [
          IconButton(
              onPressed: theme.toggle,
              icon: Icon(theme.themeMode.name == 'system'
                  ? CupertinoIcons.desktopcomputer
                  : theme.themeMode.name == 'dark'
                      ? CupertinoIcons.sun_min
                      : CupertinoIcons.moon))
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: tabs[_selectedIndex],
      )),
      bottomNavigationBar: GNav(
        gap: 8,
        iconSize: 24,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        duration: const Duration(milliseconds: 400),
        tabs: [
          const GButton(
            icon: CupertinoIcons.train_style_two,
            text: 'Tratta',
          ),
          const GButton(
            icon: CupertinoIcons.alt,
            text: 'Tabellone',
          ),
          GButton(
            icon: _selectedIndex == 2
                ? CupertinoIcons.star_fill
                : CupertinoIcons.star,
            text: 'Preferiti',
          ),
          GButton(
            icon: _selectedIndex == 3
                ? CupertinoIcons.news_solid
                : CupertinoIcons.news,
            text: 'Notizie',
          ),
        ],
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
