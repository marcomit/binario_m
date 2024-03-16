import 'package:binario_m/models/solution.dart';
import 'package:binario_m/models/station.dart';
import 'package:binario_m/utils/global.dart';
import 'package:binario_m/utils/viaggia_treno.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class SolutionsPage extends StatefulWidget {
  final Station departure;
  final Station destination;
  final DateTime date;
  List<Solution> solutions = [];
  SolutionsPage(
      {super.key,
      required this.solutions,
      required this.date,
      required this.destination,
      required this.departure});

  @override
  State<SolutionsPage> createState() => _SolutionsPageState();
}

class _SolutionsPageState extends State<SolutionsPage> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        final solutions = await ViaggiaTreno.getSolutions(
            widget.departure, widget.destination, widget.date);
        setState(() => widget.solutions = solutions);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Soluzioni'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(children: [
            for (final solution in widget.solutions) solutionCard(solution)
          ]),
        ),
      ),
    );
  }

  Widget solutionCard(Solution solution) {
    return Card(
      child: Column(
        children: solution.vehicles
            .map((vehicle) => GestureDetector(
                  onTap: () async {},
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 100,
                    child: Center(
                      child: Timeline.tileBuilder(
                        theme: TimelineThemeData(
                          nodePosition: 0,
                          nodeItemOverlap: true,
                          connectorTheme: const ConnectorThemeData(
                            color: Color(0xff383838),
                            thickness: 15.0,
                          ),
                        ),
                        padding: const EdgeInsets.only(top: 20.0),
                        builder: TimelineTileBuilder.connected(
                          indicatorBuilder: (context, index) {
                            const status = TrainState.inProgress;
                            return OutlinedDotIndicator(
                              color: status.isDone
                                  ? const Color(0xff6ad192)
                                  : const Color(0xff343434),
                              backgroundColor: status.isDone
                                  ? const Color(0xff494949)
                                  : const Color(0xffc2c5c9),
                              borderWidth: status.isDone ? 3.0 : 2.5,
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
                ))
            .toList(),
      ),
    );
  }
}

enum TrainState { done, inProgress, todo }

extension on TrainState {
  bool get isInProgress => this == TrainState.inProgress;
  bool get isDone => this == TrainState.done;
}
