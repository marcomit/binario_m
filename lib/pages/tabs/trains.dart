import 'dart:math' as math;

import 'package:binario_m/providers/recently_solutions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/station.dart';
import '../../utils/global.dart';
import '../search.dart';
import '../solutions.dart';

class TrainsTab extends StatefulWidget {
  const TrainsTab({super.key});
  @override
  State<TrainsTab> createState() => _TrainsTabState();
}

class _TrainsTabState extends State<TrainsTab> {
  Station? departure;
  Station? destination;
  DateTime selectedDate = DateTime.now();
  int hour = 0;
  int minute = 0;

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final solutionsProvider = context.watch<RecentlySolutionsProvider>();
    return ListView(children: [
      const SizedBox(height: 10),
      GestureDetector(
        onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const SearchPage(title: "Partenza")))
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
          title: Text(departure == null ? 'Partenza' : departure!.nomeBreve),
          trailing: Text(departure == null ? '' : departure!.id),
          subtitle: Text(departure == null ? '' : departure!.nomeLungo),
        ),
      ),
      GestureDetector(
          onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              const SearchPage(title: "Destinazione")))
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
              trailing: Text(destination == null ? '' : destination!.id),
              subtitle:
                  Text(destination == null ? '' : destination!.nomeLungo))),
      SizedBox(
        width: 50,
        height: 50,
        child: IconButton(
            onPressed: () {
              if (departure == null || destination == null) return;
              final dep = departure;
              setState(() {
                departure = destination;
                destination = dep;
              });
            },
            icon: const Icon(CupertinoIcons.arrow_up_arrow_down)),
      ),
      GestureDetector(
        onTap: () => _showDialog(
          CupertinoDatePicker(
            minimumDate: DateTime.now().add(const Duration(days: -1)),
            initialDateTime: DateTime.now(),
            mode: CupertinoDatePickerMode.dateAndTime,
            use24hFormat: true,
            showDayOfWeek: true,
            onDateTimeChanged: (DateTime newDate) {
              setState(() => selectedDate = newDate);
            },
          ),
        ),
        child: ListTile(
          leading: const Icon(CupertinoIcons.calendar),
          title: Text(
              '${formatNumber(selectedDate.day)} ${months[selectedDate.month - 1]}'),
          trailing: Text(
              '${formatNumber(selectedDate.hour)}:${formatNumber(selectedDate.minute)}'),
        ),
      ),
      const SizedBox(height: 20),
      SizedBox(
        width: double.infinity,
        height: 50,
        child: FloatingActionButton.extended(
          onPressed: () async {
            if (departure == null || destination == null) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text('Inserisci tutti i dati prima di cercare!')));
              return;
            }

            selectedDate.add(Duration(hours: hour, minutes: minute));

            solutionsProvider.addSolution(
                departure!, destination!, selectedDate);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => SolutionsPage(
                        date: selectedDate,
                        departure: departure!,
                        destination: destination!)));
          },
          icon: const Icon(CupertinoIcons.search),
          label: const Text('Cerca'),
        ),
      ),
      const SizedBox(height: 20),
      for (final solution in solutionsProvider.recentlySolutions)
        Text(solution.departure.code)
    ]);
  }
}
