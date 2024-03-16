import 'package:binario_m/pages/tabs/news.dart';
import 'package:binario_m/pages/tabs/train_stops.dart';
import 'package:binario_m/pages/tabs/trains.dart';
import 'package:binario_m/providers/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../models/navbar_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<NavbarItem> tabs = [
    NavbarItem(
        const GButton(
          icon: CupertinoIcons.home,
          text: 'Tratta',
        ),
        const TrainsTab()),
    NavbarItem(
        const GButton(
          icon: CupertinoIcons.alt,
          text: 'Stazione',
        ),
        const TrainStopTab()),
    NavbarItem(
        const GButton(
          icon: CupertinoIcons.train_style_one,
          text: 'Treno',
        ),
        const TrainStopTab()),
    NavbarItem(
        const GButton(
          icon: CupertinoIcons.news,
          text: 'Notizie',
        ),
        const NewsTab())
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
        padding: const EdgeInsets.all(8.0),
        child: tabs[_selectedIndex].page,
      )),
      bottomNavigationBar: GNav(
        //rippleColor: Colors.grey[300]!,
        //hoverColor: Colors.grey[100]!,
        gap: 8,
        // activeColor: Colors.black,
        iconSize: 24,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        duration: const Duration(milliseconds: 400),
        //tabBackgroundColor: Colors.grey[100]!,
        // color: Colors.black,
        tabs: tabs.map((e) => e.tab).toList(),
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
