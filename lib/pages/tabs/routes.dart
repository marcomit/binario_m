import 'package:binario_m/models/station.dart';
import 'package:binario_m/pages/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/viaggia_treno.dart';

class RoutesTab extends StatefulWidget {
  const RoutesTab({super.key});

  @override
  State<RoutesTab> createState() => _RoutesTabState();
}

class _RoutesTabState extends State<RoutesTab> {
  List<Route> trainStops = [];
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
              await ViaggiaTreno.getTable(value as Station);
              setState(() {
                station = value;
              });
            });
          },
          child: const Icon(CupertinoIcons.search),
        )
      ],
    );
  }
}
