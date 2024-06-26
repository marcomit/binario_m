import 'package:binario_m/models/train_info.dart';
import 'package:binario_m/pages/schedule_notification.dart';
import 'package:binario_m/pages/table.dart';
import 'package:binario_m/utils/global.dart';
import 'package:binario_m/utils/viaggia_treno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class TrainDetailsPage extends StatefulWidget {
  final String trainNumber;
  final bool isToday;
  const TrainDetailsPage(
      {super.key, required this.trainNumber, required this.isToday});

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
          appBar: AppBar(title: Text(widget.trainNumber)),
          body: FutureBuilder(
              future: ViaggiaTreno.searchTrainNumber(widget.trainNumber),
              builder: (ctx, snapshotData) {
                if (snapshotData.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshotData.hasError) {
                  return const Center(
                      child:
                          Text('Errore durante il recupero delle soluzioni'));
                }
                if (snapshotData.hasData) {
                  if (snapshotData.data == null) {
                    return const Center(
                        child:
                            Text('Errore durante il recupero delle soluzioni'));
                  }
                  final trainInfo = snapshotData.data as TrainInfo;
                  return FutureBuilder(
                    future:
                        ViaggiaTreno.getTrainDetailsFromTrainInfo(trainInfo),
                    builder: (_, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                              'Errore durante il recupero delle soluzioni'),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Timeline.tileBuilder(
                              theme: TimelineThemeData(
                                nodePosition: 0,
                                nodeItemOverlap: true,
                                connectorTheme: const ConnectorThemeData(
                                  color: Color(0xff383838),
                                  thickness: 2.0,
                                ),
                              ),
                              padding: const EdgeInsets.only(bottom: 50),
                              builder: TimelineTileBuilder.connected(
                                indicatorBuilder: (context, index) {
                                  final current = snapshot.data![index];
                                  return OutlinedDotIndicator(
                                    color: const Color(0xff343434),
                                    backgroundColor:
                                        current.arrivoReale && widget.isToday
                                            ? const Color(0xff6ad192)
                                            : const Color(0xff222222),
                                    borderWidth: 3.0,
                                  );
                                },
                                connectorBuilder:
                                    (context, index, connectorType) {
                                  final current = snapshot.data![index];
                                  final next = snapshot.data![index +
                                      1]; // il metodo viene eseguito fino al penultimo quindi non è necessario effettuare controlli
                                  if (!widget.isToday) {
                                    return const DashedLineConnector(
                                        color: Color(0xff343434));
                                  }
                                  if (current.partenzaReale &&
                                      connectorType == ConnectorType.end) {
                                    return const DashedLineConnector(
                                        color: Color(0xff6ad192));
                                  }
                                  if (next.arrivoReale &&
                                      connectorType == ConnectorType.start) {
                                    return const DashedLineConnector(
                                        color: Color(0xff6ad192));
                                  }
                                  return const DashedLineConnector(
                                      color: Color(0xff343434));
                                },
                                contentsBuilder: (context, index) {
                                  final current = snapshot.data![index];
                                  final ritardoPartenza = replaceOn(
                                      current.fermata.ritardoPartenza, null, 0);
                                  final ritardoArrivo = replaceOn(
                                      current.fermata.ritardoArrivo, null, 0);
                                  return Transform.translate(
                                    offset: const Offset(0, 30),
                                    child: SizedBox(
                                      height: 80,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                    child: Text(
                                                  current.stazione,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                const SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        if (!current.first)
                                                          const Text('Arrivo'),
                                                        if (!current.last)
                                                          const Text(
                                                              'Partenza'),
                                                      ],
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        if (!current.first)
                                                          Text(formatDate(current
                                                                      .fermata
                                                                      .arrivoTeorico ==
                                                                  null
                                                              ? null
                                                              : DateTime.fromMillisecondsSinceEpoch(
                                                                  current
                                                                      .fermata
                                                                      .arrivoTeorico!))),
                                                        if (!current.last)
                                                          Text(formatDate(current
                                                                      .fermata
                                                                      .partenzaTeorica ==
                                                                  null
                                                              ? null
                                                              : DateTime.fromMillisecondsSinceEpoch(
                                                                  current
                                                                      .fermata
                                                                      .partenzaTeorica!))),
                                                      ],
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        if (!current.first)
                                                          Text(formatDate(current
                                                                      .fermata
                                                                      .arrivoReale ==
                                                                  null
                                                              ? null
                                                              : DateTime.fromMillisecondsSinceEpoch(
                                                                  current
                                                                      .fermata
                                                                      .arrivoReale!))),
                                                        if (!current.last)
                                                          Text(formatDate(current
                                                                      .fermata
                                                                      .partenzaReale ==
                                                                  null
                                                              ? null
                                                              : DateTime.fromMillisecondsSinceEpoch(
                                                                  current
                                                                      .fermata
                                                                      .partenzaReale!))),
                                                      ],
                                                    ),
                                                    const SizedBox(width: 10),
                                                    if (widget.isToday)
                                                      Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            if (!current.first)
                                                              textDelay(
                                                                  ritardoArrivo!),
                                                            if (!current.last)
                                                              textDelay(
                                                                  ritardoPartenza!),
                                                          ])
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                PopupMenuButton(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    itemBuilder: (context) => [
                                                          PopupMenuItem(
                                                              onTap: () async {
                                                                ViaggiaTreno.getStationDetails(
                                                                        current
                                                                            .id)
                                                                    .then((value) => value ==
                                                                            null
                                                                        ? null
                                                                        : Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (_) => TablePage(station: value))));
                                                              },
                                                              child:
                                                                  const ListTile(
                                                                leading: Icon(
                                                                    CupertinoIcons
                                                                        .table),
                                                                title: Text(
                                                                    'Tabellone orari'),
                                                              )),
                                                          PopupMenuItem(
                                                              onTap: () => Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (_) =>
                                                                              const ScheduleNotificationPage())),
                                                              child:
                                                                  const ListTile(
                                                                leading: Icon(
                                                                    CupertinoIcons
                                                                        .timer),
                                                                title: Text(
                                                                    'Notifica orario'),
                                                              ))
                                                        ],
                                                    child: Text(
                                                      current.id,
                                                      style: const TextStyle(
                                                          color: Colors.blue,
                                                          decorationColor:
                                                              Colors.blue,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline),
                                                    )),
                                                if (!current.first &&
                                                    widget.isToday)
                                                  Text(replaceOn(
                                                      current.fermata
                                                          .binarioEffettivoArrivoDescrizione,
                                                      null,
                                                      replaceOn(
                                                          current.fermata
                                                              .binarioProgrammatoArrivoDescrizione,
                                                          null,
                                                          ''))),
                                                if (!current.last &&
                                                    widget.isToday)
                                                  Text(replaceOn(
                                                      current.fermata
                                                          .binarioEffettivoPartenzaDescrizione,
                                                      null,
                                                      replaceOn(
                                                          current.fermata
                                                              .binarioProgrammatoPartenzaDescrizione,
                                                          null,
                                                          ''))),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: snapshot.data!.length,
                              )),
                        );
                      }
                      return const Center(
                          child: Text('Non ci sono dati da visualizzare'));
                    },
                  );
                }
                return const Center(child: Text('Non ci sono soluzioni!'));
              })),
    );
  }

  Widget textDelay(int delay) => Text(
      delay == 0
          ? ''
          : delay < 0
              ? '$delay'
              : '+$delay',
      style: TextStyle(color: delay > 0 ? Colors.red : Colors.green));
}
