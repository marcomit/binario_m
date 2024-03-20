import 'package:binario_m/pages/search.dart';
import 'package:binario_m/pages/table.dart';
import 'package:binario_m/utils/viaggia_treno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/station.dart';

class StationTab extends StatefulWidget {
  const StationTab({super.key});

  @override
  State<StationTab> createState() => _StationTabState();
}

class _StationTabState extends State<StationTab> {
  Station? station;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            const SearchPage(title: "Destinazione")))
                .then((value) async {
              if (value is Station) {
                await ViaggiaTreno.getTable(value);
                await ViaggiaTreno.getTable(value, false);
                Navigator.push(context,
                    CupertinoPageRoute(builder: (_) => const TablePage()));
              }
            }),
        child: ListTile(
            leading: const Icon(CupertinoIcons.arrow_right),
            title: Text(station == null ? 'Stazione' : station!.nomeBreve),
            trailing: Text(station == null ? '' : station!.id),
            subtitle: Text(station == null ? '' : station!.nomeLungo)));
  }
}
