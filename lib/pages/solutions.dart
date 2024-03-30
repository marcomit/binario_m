import 'package:binario_m/models/solution.dart';
import 'package:binario_m/models/station.dart';
import 'package:binario_m/pages/train_details.dart';
import 'package:binario_m/utils/global.dart';
import 'package:binario_m/utils/viaggia_treno.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class SolutionsPage extends StatefulWidget {
  final Station departure;
  final Station destination;
  final DateTime date;
  const SolutionsPage(
      {super.key,
      required this.date,
      required this.destination,
      required this.departure});

  @override
  State<SolutionsPage> createState() => _SolutionsPageState();
}

class _SolutionsPageState extends State<SolutionsPage> {
  int refreshCount = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => setState(() => refreshCount++),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Soluzioni'),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: FutureBuilder(
            future: ViaggiaTreno.getSolutions(
                widget.departure, widget.destination, widget.date),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(
                    child: Text('Errore durante il recupero delle soluzioni!'));
              }
              if (snapshot.hasData) {
                return ListView(children: [
                  for (final solution in snapshot.data!) solutionCard(solution)
                ]);
              }
              return const Center(child: Text('Non ci sono dati!'));
            },
          ),
        ),
      ),
    );
  }

  Widget solutionCard(Solution solution) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final vehicle in solution.vehicles)
              GestureDetector(
                onTap: () async {
                  final trainInfo =
                      await ViaggiaTreno.searchTrainNumber(vehicle.numeroTreno);
                  if (trainInfo == null) return;
                  if (!mounted) return;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => TrainDetailsPage(
                              trainInfo: trainInfo,
                              isToday: isToday(vehicle.orarioPartenza))));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        '${vehicle.categoriaDescrizione} ${vehicle.numeroTreno}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 80,
                      child: Center(
                        child: Timeline.tileBuilder(
                          physics: const NeverScrollableScrollPhysics(),
                          theme: TimelineThemeData(
                            nodePosition: 0,
                            nodeItemOverlap: true,
                            connectorTheme: const ConnectorThemeData(
                              color: Color(0xff383838),
                              thickness: 15.0,
                            ),
                          ),
                          builder: TimelineTileBuilder.connected(
                            indicatorBuilder: (context, index) {
                              const status = TrainState.inProgress;
                              return const OutlinedDotIndicator(
                                color: status == TrainState.done
                                    ? Color(0xff6ad192)
                                    : Color(0xff343434),
                                backgroundColor: status == TrainState.done
                                    ? Color(0xff494949)
                                    : Color(0xffc2c5c9),
                                borderWidth:
                                    status == TrainState.done ? 3.0 : 2.5,
                              );
                            },
                            connectorBuilder: (context, index, connectorType) {
                              return const SolidLineConnector();
                            },
                            contentsBuilder: (context, index) {
                              return SizedBox(
                                height: 40,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      index == 0
                                          ? '${formatNumber(vehicle.orarioPartenza.hour)}:${formatNumber(vehicle.orarioPartenza.minute)} ${vehicle.origine}'
                                          : '${formatNumber(vehicle.orarioArrivo.hour)}:${formatNumber(vehicle.orarioArrivo.minute)} ${vehicle.destinazione}',
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Text(
                '${formatNumber(solution.duration.inMinutes ~/ 60)}:${formatNumber(solution.duration.inMinutes % 60)}'),
          ],
        ),
      ),
    );
  }
}
