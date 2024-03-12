import 'package:binario_m/models/station.dart';
import 'package:binario_m/pages/search.dart';
import 'package:binario_m/pages/solutions.dart';
import 'package:binario_m/utils/global.dart';
import 'package:binario_m/utils/viaggia_treno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Station? departure;
  Station? destination;
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime initialDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != initialDate) {
      // ignore: use_build_context_synchronously
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() => selectedDate = picked
            .add(Duration(hours: pickedTime.hour, minutes: pickedTime.minute)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Treni")),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
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
            GestureDetector(
              onTap: () async => await _selectDate(context),
              child: ListTile(
                leading: const Icon(CupertinoIcons.calendar),
                title: Text(
                    '${formatNumber(selectedDate.day)} ${months[selectedDate.month]}'),
                trailing: Text(
                    '${formatNumber(selectedDate.hour)}:${formatNumber(selectedDate.minute)}'),
              ),
            ),
            FloatingActionButton(
              onPressed: () async {
                if (departure != null && destination != null) {
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
                }
              },
              child: const Icon(CupertinoIcons.search),
            )
          ]),
        ));
  }
}
