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
                        thickness: 15.0,
                      ),
                    ),
                    padding: const EdgeInsets.only(top: 20.0),
                    builder: TimelineTileBuilder.connected(
                      indicatorBuilder: (context, index) {
                        final current = snapshot.data![index];
                        return OutlinedDotIndicator(
                          color: current['partenzaReale'] == true
                              ? Color(0xff6ad192)
                              : Color(0xff343434),
                          backgroundColor: current['partenzaReale'] == true
                              ? Color(0xff494949)
                              : Color(0xffc2c5c9),
                          borderWidth:
                              current['partenzaReale'] == true ? 3.0 : 2.5,
                        );
                      },
                      connectorBuilder: (context, index, connectorType) {
                        return const SolidLineConnector();
                      },
                      contentsBuilder: (context, index) {
                        final current = snapshot.data![index];
                        final programmata = DateTime.fromMillisecondsSinceEpoch(
                            current['fermata']['programmata']);
                        return SizedBox(
                          height: 40,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                  '${formatNumber(programmata.hour)}:${formatNumber(programmata.minute)} ${current['stazione']}'),
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
        ),
      ),
    );
  }
}
