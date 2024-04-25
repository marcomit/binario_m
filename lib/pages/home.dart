import 'package:binario_m/pages/tabs/color_picker.dart';
import 'package:binario_m/pages/tabs/news.dart';
import 'package:binario_m/pages/tabs/station.dart';
import 'package:binario_m/pages/tabs/trains.dart';
import 'package:binario_m/providers/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/components.dart';

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
    //const FavouritesTab(),
    const NewsTab(),
    const ColorPickerTab()
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
      bottomNavigationBar: NeuBottomNav(
          icons: const [
            CupertinoIcons.home,
            CupertinoIcons.alt,
            CupertinoIcons.news,
            CupertinoIcons.color_filter
          ],
          onIconTap: (index) => setState(() => _selectedIndex = index),
          autoHideOnScroll: false,
          scrollController: ScrollController()),
    );
  }
}
