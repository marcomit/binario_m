import 'package:binario_m/pages/search.dart';
import 'package:binario_m/pages/table.dart';
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
        onTap: () => Navigator.push<Station>(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        const SearchPage(title: "Destinazione"))).then((value) {
              if (value == null) return;
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (_) => TablePage(station: value)));
            }),
        child: ListTile(
            leading: const Icon(CupertinoIcons.arrow_right),
            title: Text(station == null ? 'Stazione' : station!.nomeBreve),
            trailing: Text(station == null ? '' : station!.id),
            subtitle: Text(station == null ? '' : station!.nomeLungo)));
  }
}
