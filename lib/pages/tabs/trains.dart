import 'dart:math' as math;

import 'package:binario_m/components/components.dart';
import 'package:binario_m/utils/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../components/ui/buttons/_button.dart';
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
  int _refreshCount = 0;

  @override
  void initState() {
    super.initState();
  }

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
    List<Widget> items = [
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
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
          child: NeuCard(
            borderRadius: BorderRadius.circular(10),
            child: ListTile(
              leading: Transform.rotate(
                  angle: -math.pi / 4,
                  child: const Icon(CupertinoIcons.arrow_right)),
              title:
                  Text(departure == null ? 'Partenza' : departure!.nomeBreve),
              trailing: Text(departure == null ? '' : departure!.id),
              subtitle: Text(departure == null ? '' : departure!.nomeLungo),
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
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
            child: NeuCard(
              borderRadius: BorderRadius.circular(10),
              child: ListTile(
                  leading: Transform.rotate(
                      angle: math.pi / 4,
                      child: const Icon(CupertinoIcons.arrow_right)),
                  title: Text(destination == null
                      ? 'Destinazione'
                      : destination!.nomeBreve),
                  trailing: Text(destination == null ? '' : destination!.id),
                  subtitle:
                      Text(destination == null ? '' : destination!.nomeLungo)),
            )),
      ),
      const SizedBox(height: 10),
      IconButton(
          onPressed: () {
            if (departure == null || destination == null) return;
            final dep = departure;
            setState(() {
              departure = destination;
              destination = dep;
            });
          },
          icon: const Icon(CupertinoIcons.arrow_up_arrow_down)),
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
      Container(
        padding: const EdgeInsets.all(10),
        height: 70,
        child: NeuButton(
          buttonColor: Theme.of(context).primaryColor,
          onPressed: () async {
            if (departure == null || destination == null) {
              const NeuToast()
                  .show(context, 'Inserisci tutti i dati prima di cercare!');
              return;
            }

            selectedDate.add(Duration(hours: hour, minutes: minute));

            // Aggionge la soluzione al DB
            var departureId = await LocalStorage.getStationByCode(departure!);
            var destinationId =
                await LocalStorage.getStationByCode(destination!);
            departureId ??= await LocalStorage.insertStation(departure!);
            destinationId ??= await LocalStorage.insertStation(destination!);

            await LocalStorage.insertSolution(
                departureId!, destinationId!, selectedDate);

            if (!context.mounted) return;

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => SolutionsPage(
                        date: selectedDate,
                        departure: departure!,
                        destination: destination!))).then((value) =>
                value == null ? setState(() => _refreshCount++) : null);
          },
          borderRadius: BorderRadius.circular(10),
          enableAnimation: true,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.search),
              SizedBox(width: 10),
              Text('Cerca'),
            ],
          ),
        ),
      ),
      const SizedBox(height: 20),
      FutureBuilder(
          future: LocalStorage.getRecentlySolutions(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Errore durante il recupero delle soluzioni'),
              );
            }
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('Non ci sono soluzioni'),
                );
              }
              final recentlySolutions = snapshot.data!;
              for (var element in recentlySolutions) {
                debugPrint(
                    '${element.departure.id} - ${element.destination.id}');
              }
              return Column(
                  children: recentlySolutions
                      .map((solution) => Padding(
                            padding: const EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () => setState(() {
                                departure = Station.fromDB(solution.departure);
                                destination =
                                    Station.fromDB(solution.destination);
                                selectedDate = DateTime(
                                    selectedDate.year,
                                    selectedDate.month,
                                    selectedDate.day,
                                    solution.date.hour,
                                    solution.date.minute);
                              }),
                              child: NeuCard(
                                borderRadius: BorderRadius.circular(10),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Row(children: [
                                        Text(formatDate(solution.date)),
                                        const Spacer(),
                                        IconButton(
                                          onPressed: () => showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text(
                                                  'Elimina soluzione',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              content: Text(
                                                  'Sei certo di voler eliminare la soluzione ${solution.departure.shortName} - ${solution.destination.shortName} per il ${formatDate(solution.date)}?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, false),
                                                  child: const Text('Annulla'),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    await LocalStorage
                                                        .deleteSolution(
                                                            solution.id!);
                                                    setState(() {
                                                      recentlySolutions
                                                          .removeWhere(
                                                              (element) =>
                                                                  element.id ==
                                                                  solution.id);
                                                    });
                                                    if (context.mounted) {
                                                      Navigator.pop(
                                                          context, true);
                                                    }
                                                  },
                                                  child: const Text('Elimina'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          iconSize: 15,
                                          icon:
                                              const Icon(CupertinoIcons.delete),
                                        )
                                      ]),
                                    ),
                                    ListTile(
                                      horizontalTitleGap: 0,
                                      title: Text(
                                        solution.departure.shortName,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle:
                                          Text(solution.departure.longName),
                                      trailing: Text(solution.departure.code),
                                    ),
                                    ListTile(
                                      title: Text(
                                          solution.destination.shortName,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      subtitle:
                                          Text(solution.destination.longName),
                                      trailing: Text(solution.destination.code),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList());
            }
            return const Center(child: Text('Non ci sono soluzioni'));
          })
    ];
    return AnimationLimiter(
        child: ListView(children: [
      for (int i = 0; i < items.length; i++)
        AnimationConfiguration.staggeredList(
            position: i,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
                horizontalOffset: 100.0,
                child: FadeInAnimation(child: items[i])))
    ]));
  }
}
