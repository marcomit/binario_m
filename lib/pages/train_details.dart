import 'package:binario_m/models/train_info.dart';
import 'package:binario_m/utils/global.dart';
import 'package:binario_m/utils/viaggia_treno.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class TrainDetailsPage extends StatefulWidget {
  final TrainInfo trainInfo;
  final bool isToday;
  const TrainDetailsPage(
      {super.key, required this.trainInfo, required this.isToday});

  @override
  State<TrainDetailsPage> createState() => _TrainDetailsPageState();
}

class _TrainDetailsPageState extends State<TrainDetailsPage> {
  int refresh = 0;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => setState(() => refresh++),
      child: Scaffold(
        appBar: AppBar(title: const Text('Dettagli tratta')),
        body: FutureBuilder(
          future: ViaggiaTreno.getTrainDetails(widget.trainInfo),
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Errore durante il recupero delle soluzioni'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                child: Timeline.tileBuilder(
                    theme: TimelineThemeData(
                      nodePosition: 0,
                      nodeItemOverlap: true,
                      connectorTheme: const ConnectorThemeData(
                        color: Color(0xff383838),
                        thickness: 2.0,
                      ),
                    ),
                    padding: const EdgeInsets.only(top: 20.0, bottom: 30),
                    builder: TimelineTileBuilder.connected(
                      indicatorBuilder: (context, index) {
                        final current = snapshot.data![index];
                        return OutlinedDotIndicator(
                          color: const Color(0xff343434),
                          backgroundColor:
                              current['arrivoReale'] == true && widget.isToday
                                  ? const Color(0xff6ad192)
                                  : const Color(0xff343434),
                          borderWidth:
                              current['partenzaReale'] == true ? 3.0 : 2.5,
                        );
                      },
                      connectorBuilder: (context, index, connectorType) {
                        final current = snapshot.data![index];
                        Color color = const Color(0xff6ad192);
                        if (!widget.isToday) {
                          color = const Color(0xff343434);
                        } else if (connectorType == ConnectorType.end) {
                          if (!current['arrivoReale']) {
                            color = const Color(0xff343434);
                          }
                        } else {
                          if (!current['partenzaReale']) {
                            color = const Color(0xff343434);
                          }
                        }
                        return DashedLineConnector(color: color);
                      },
                      contentsBuilder: (context, index) {
                        final current = snapshot.data![index];
                        final programmata = DateTime.fromMillisecondsSinceEpoch(
                            current['fermata']['programmata']);
                        return SizedBox(
                          height: 100,
                          child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(current['stazione']),
                                      Row(
                                        children: [
                                          const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Arrivo'),
                                              Text('Partenza'),
                                            ],
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(formatDate(current['fermata']
                                                          ['arrivo_teorico'] ==
                                                      null
                                                  ? null
                                                  : DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          current['fermata'][
                                                              'arrivo_teorico']))),
                                              Text(formatDate(current['fermata']
                                                          [
                                                          'partenza_teorica'] ==
                                                      null
                                                  ? null
                                                  : DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          current['fermata'][
                                                              'partenza_teorica'])))
                                            ],
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(formatDate(current['fermata']
                                                          ['arrivoReale'] ==
                                                      null
                                                  ? null
                                                  : DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          current['fermata'][
                                                              'arrivoReale']))),
                                              Text(formatDate(current['fermata']
                                                          ['partenzaReale'] ==
                                                      null
                                                  ? null
                                                  : DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          current['fermata'][
                                                              'partenzaReale'])))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      const Text(""),
                                      Text(current['fermata'][
                                              'binarioEffettivoArrivoDescrizione']
                                          .toString()),
                                      Text(current['fermata'][
                                              'binarioEffettivoPartenzaDescrizione']
                                          .toString()),
                                    ],
                                  )
                                ],
                              )),
                        );
                      },
                      itemCount: snapshot.data!.length,
                    )),
              );
            }
            return const Center(
                child: Text('Non ci sono dati da visualizzare'));
          },
        ),
      ),
    );
  }
}
