import 'dart:math' as math;

import 'package:binario_m/pages/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../components/route_card.dart';
import '../../models/station.dart';
import '../../models/train_route.dart';
import '../../utils/viaggia_treno.dart';

class StationTab extends StatefulWidget {
  const StationTab({super.key});

  @override
  State<StationTab> createState() => _StationTabState();
}

class _StationTabState extends State<StationTab> {
  Station? station;
  List<TrainRoute>? departures;
  List<TrainRoute>? arrivals;
  bool _isArrival = false;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => setState(() => _isArrival = _isArrival),
      child: ListView(
        children: [
          GestureDetector(
              onTap: () => Navigator.push<Station>(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  const SearchPage(title: "Fermata")))
                      .then((value) async {
                    if (value == null) return;
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (_) => TablePage(station: value)));
                    final arrivalsFetched = await ViaggiaTreno.getTable(value);
                    final departuresFetched =
                        await ViaggiaTreno.getTable(value, false);
                    setState(() {
                      arrivals = arrivalsFetched;
                      departures = departuresFetched;
                      station = value;
                    });
                  }),
              child: ListTile(
                  leading: Transform.rotate(
                      angle: -math.pi / 4,
                      child: const Icon(CupertinoIcons.arrow_right)),
                  title:
                      Text(station == null ? 'Stazione' : station!.nomeBreve),
                  trailing: Text(station == null ? '' : station!.id),
                  subtitle: Text(station == null ? '' : station!.nomeLungo))),
          CupertinoSlidingSegmentedControl<bool>(
            //backgroundColor: CupertinoColors.systemGrey2,
            groupValue: _isArrival,
            onValueChanged: (value) =>
                value == null ? null : setState(() => _isArrival = value),
            children: const <bool, Widget>{
              true: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Partenze',
                ),
              ),
              false: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Arrivi',
                ),
              ),
            },
          ),
          if (station == null)
            const Padding(
              padding: EdgeInsets.all(40.0),
              child: Center(
                  child: Text("Clicca sulla stazione per iniziare la ricerca")),
            )
          else if (arrivals == null || departures == null)
            const Padding(
              padding: EdgeInsets.all(40.0),
              child: Center(
                  child: Text("Clicca sulla stazione per iniziare la ricerca")),
            )
          else
            routesList(_isArrival ? arrivals! : departures!, _isArrival)
        ],
      ),
    );
  }

  Widget tableList(bool isArrival) => FutureBuilder(
      future: ViaggiaTreno.getTable(station!, isArrival),
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
      }));

  Widget routesList(List<TrainRoute> routes, bool isArrival) =>
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
}
