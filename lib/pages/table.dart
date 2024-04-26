import 'package:binario_m/models/station.dart';
import 'package:binario_m/models/train_route.dart';
import 'package:binario_m/utils/viaggia_treno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../components/route_card.dart';

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
                return routesList2(
                    snapshot.data as List<TrainRoute>, isArrival);
              }
              return const Center(child: CircularProgressIndicator());
            })),
      );
  Widget routesList2(List<TrainRoute> routes, bool isArrival) =>
      AnimationLimiter(
          child: Column(children: [
        for (int index = 0; index < routes.length; index++)
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
          )
      ]));
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
