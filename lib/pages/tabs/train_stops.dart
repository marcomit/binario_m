import 'package:binario_m/models/station.dart';
import 'package:binario_m/pages/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/train_stop.dart';
import '../../utils/viaggia_treno.dart';

class TrainStopTab extends StatefulWidget {
  const TrainStopTab({super.key});

  @override
  State<TrainStopTab> createState() => _TrainStopTabState();
}

class _TrainStopTabState extends State<TrainStopTab> {
  List<TrainStop> trainStops = [];
  Station? station;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(station == null ? 'Seleziona una stazione' : station!.nomeLungo),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const SearchPage(title: "Fermata")))
                .then((value) async {
              if (value == null) return;
              final res = await ViaggiaTreno.getDepartures(value as Station);
              setState(() {
                station = value as Station;
              });
            });
          },
          child: const Icon(CupertinoIcons.search),
        )
      ],
    );
  }
}
