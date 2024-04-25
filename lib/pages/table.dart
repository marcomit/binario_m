import 'package:avatar_glow/avatar_glow.dart';
import 'package:binario_m/components/components.dart';
import 'package:binario_m/models/station.dart';
import 'package:binario_m/models/train_route.dart';
import 'package:binario_m/pages/train_details.dart';
import 'package:binario_m/utils/global.dart';
import 'package:binario_m/utils/viaggia_treno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:timelines/timelines.dart';

class TablePage extends StatefulWidget {
  final Station station;
  const TablePage({super.key, required this.station});

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  int refresh = 0;

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text(widget.station.nomeBreve),
              bottom: const TabBar(
                tabs: [Tab(text: 'Partenze'), Tab(text: 'Arrivi')],
              ),
            ),
            body: TabBarView(children: [tableList(false), tableList()])),
      );

  Widget tableList([bool isArrival = true]) => RefreshIndicator(
        onRefresh: () async => setState(() => refresh++),
        child: FutureBuilder(
            future: ViaggiaTreno.getTable(widget.station, isArrival),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const Center(child: Text('Non ci sono dati!'));
                }
                return routesList(snapshot.data as List<TrainRoute>, isArrival);
              }
              return const Center(child: CircularProgressIndicator());
            })),
      );

  Widget routesList(List<TrainRoute> routes, bool isArrival) =>
      AnimationLimiter(
        child: ListView.builder(
            itemCount: routes.length,
            itemBuilder: (context, index) =>
                AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                        child: RouteCard(
                      isArrival: isArrival,
                      trainRoute: routes[index],
                    )),
                  ),
                )),
      );
}

class RouteCard extends StatelessWidget {
  final TrainRoute trainRoute;
  final bool isArrival;
  const RouteCard(
      {super.key, required this.isArrival, required this.trainRoute});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: NeuCard(
            // cardColor: Colors.white,
            borderRadius: BorderRadius.circular(10),
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => TrainDetailsPage(
                          trainNumber: trainRoute.numeroTreno.toString(),
                          isToday: true))),
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            (isArrival
                                ? replaceOn(trainRoute.origine, null, 'ORIGINE')
                                : replaceOn(trainRoute.destionazione, null,
                                    'DESTINAZIONE')),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 10),
                          Text(trainRoute.compNumeroTreno.trim()),
                          const Spacer(),
                          Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Color.fromARGB(99, 0, 100, 182)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Text(
                              replaceOn(
                                  isArrival
                                      ? trainRoute.binarioEffettivoArrivo
                                      : trainRoute.binarioEffettivoPartenza,
                                  null,
                                  replaceOn(
                                      isArrival
                                          ? trainRoute.binarioProgrammatoArrivo
                                          : trainRoute
                                              .binarioProgrammatoPartenza,
                                      null,
                                      ' ')),
                              style: const TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Row(children: [
                        AvatarGlow(
                          animate: _animateGlow(trainRoute, isArrival),
                          glowColor: trainRoute.nonPartito
                              ? Colors.grey
                              : trainRoute.ritardo > 0
                                  ? Colors.red
                                  : Colors.green,
                          child: Material(
                            elevation: 8.0,
                            shape: const CircleBorder(),
                            child: DotIndicator(
                              color: trainRoute.nonPartito
                                  ? Colors.grey
                                  : trainRoute.ritardo > 0
                                      ? Colors.red
                                      : Colors.green,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(trainRoute.nonPartito
                            ? 'Non partito'
                            : trainRoute.ritardo > 0
                                ? 'In ritardo di ${trainRoute.ritardo} minuti'
                                : 'Treno in orario'),
                        const Spacer(),
                        Text(isArrival
                            ? formatDate(trainRoute.orarioArrivo)
                            : formatDate(trainRoute.orarioPartenza)),
                      ]),
                    ],
                  )),
            )));
  }

  bool _animateGlow(TrainRoute trainRoute, bool isArrival) {
    if (isArrival) {
      final difference =
          trainRoute.orarioArrivo!.difference(DateTime.now()).inMinutes;
      debugPrint(difference.toString());
      return difference < 10 && difference >= 0;
    } else {
      final difference =
          trainRoute.orarioPartenza!.difference(DateTime.now()).inMinutes;
      debugPrint(difference.toString());
      return difference < 10 && difference >= 0;
    }
  }
}
