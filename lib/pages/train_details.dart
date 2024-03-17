import 'package:binario_m/models/train_info.dart';
import 'package:binario_m/utils/global.dart';
import 'package:binario_m/utils/viaggia_treno.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class TrainDetailsPage extends StatefulWidget {
  final TrainInfo trainInfo;
  const TrainDetailsPage({super.key, required this.trainInfo});

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
                          color: current['partenzaReale'] == true ||
                                  current['last']
                              ? Color(0xff6ad192)
                              : Color(0xff343434),
                          backgroundColor: Color(0xff494949),
                          borderWidth:
                              current['partenzaReale'] == true ? 3.0 : 2.5,
                        );
                      },
                      connectorBuilder: (context, index, connectorType) {
                        final current = snapshot.data![index];
                        return DashedLineConnector(
                            color: current['partenzaReale'] == true
                                ? Color(0xff6ad192)
                                : Color(0xff343434));
                      },
                      contentsBuilder: (context, index) {
                        final current = snapshot.data![index];
                        final programmata = DateTime.fromMillisecondsSinceEpoch(
                            current['fermata']['programmata']);
                        return SizedBox(
                          height: 100,
                          child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(current['stazione']),
                                  Text(
                                      'Arrivo ${formatDate(current['fermata']['arrivo_teorica'] == null ? null : DateTime.fromMillisecondsSinceEpoch(current['fermata']['arrivo_teorica']))}'),
                                  Text(
                                      'Partenza ${formatDate(current['fermata']['partenza_teorica'] == null ? null : DateTime.fromMillisecondsSinceEpoch(current['fermata']['partenza_teorica']))}')
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
