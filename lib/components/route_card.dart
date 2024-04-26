import 'package:avatar_glow/avatar_glow.dart';
import 'package:binario_m/components/ui/containers/neu_card.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

import '../models/train_route.dart';
import '../pages/train_details.dart';
import '../utils/global.dart';

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
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context)
                                    .primaryColor
                                    .withAlpha(70)),
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
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
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
                            elevation: 0,
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
    var difference = 0;
    if (isArrival) {
      difference =
          trainRoute.orarioArrivo!.difference(DateTime.now()).inMinutes;
    } else {
      difference =
          trainRoute.orarioPartenza!.difference(DateTime.now()).inMinutes;
    }
    return difference < 10 && difference >= 0;
  }
}
