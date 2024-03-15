import 'dart:math' as math;

import 'package:binario_m/models/news.dart';
import 'package:binario_m/models/station.dart';
import 'package:binario_m/pages/search.dart';
import 'package:binario_m/pages/solutions.dart';
import 'package:binario_m/providers/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

import '../utils/global.dart';
import '../utils/viaggia_treno.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Station? departure;
  Station? destination;
  DateTime selectedDate = DateTime.now();
  int hour = 0;
  int minute = 0;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime initialDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != initialDate) {
      setState(() => selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Treni"),
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
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            SizedBox(
                height: 50,
                child: FutureBuilder<List<News>>(
                    future: ViaggiaTreno.getNews(),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.isNotEmpty) {
                          String news = "";
                          for (final text in (snapshot.data as List<News>)) {
                            news += "${text.text} - ";
                          }
                          return Marquee(text: news);
                        }
                      }
                      return const Text('News');
                    })),
            GestureDetector(
              onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SearchPage()))
                  .then((value) {
                if (value is Station) {
                  setState(() {
                    departure = value;
                  });
                }
              }),
              child: ListTile(
                  leading: Transform.rotate(
                      angle: -math.pi / 4,
                      child: const Icon(CupertinoIcons.arrow_right)),
                  title: Text(
                      departure == null ? 'Partenza' : departure!.nomeBreve)),
            ),
            GestureDetector(
              onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SearchPage()))
                  .then((value) {
                if (value is Station) {
                  setState(() {
                    destination = value;
                  });
                }
              }),
              child: ListTile(
                leading: Transform.rotate(
                    angle: math.pi / 4,
                    child: const Icon(CupertinoIcons.arrow_right)),
                title: Text(destination == null
                    ? 'Destinazione'
                    : destination!.nomeBreve),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () async => await _selectDate(context),
                  child: Row(
                    children: [
                      const Icon(CupertinoIcons.calendar),
                      const SizedBox(width: 10),
                      Text(
                          '${formatNumber(selectedDate.day)} ${months[selectedDate.month]}'),
                    ],
                  ),
                ),
                const Divider(),
                NumberPicker(
                    minValue: 0,
                    maxValue: 23,
                    value: hour,
                    onChanged: (_) {
                      setState(() => hour = _);
                    }),
                NumberPicker(
                    minValue: 0,
                    maxValue: 59,
                    value: minute,
                    onChanged: (_) => setState(() => minute = _)),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FloatingActionButton.extended(
                onPressed: () async {
                  if (departure != null && destination != null) {
                    selectedDate.add(Duration(hours: hour, minutes: minute));
                    ViaggiaTreno.getSolutions(
                            departure!, destination!, selectedDate)
                        .then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SolutionsPage(
                                    solutions: value,
                                    date: selectedDate,
                                    departure: departure!,
                                    destination: destination!))));
                  } else {
                    SnackBar(
                      content: const Text('Yay! A SnackBar!'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          // Some code to undo the change.
                        },
                      ),
                    );
                  }
                },
                icon: const Icon(CupertinoIcons.search),
                label: const Text('Cerca'),
              ),
            ),
          ]),
        ));
  }
}
