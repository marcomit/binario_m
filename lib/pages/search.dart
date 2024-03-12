import 'package:binario_m/models/station.dart';
import 'package:binario_m/utils/viaggia_treno.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Station> stations = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stazioni'),
      ),
      body: ListView(
        children: [
          TextField(
            onChanged: (value) async {
              final response = await ViaggiaTreno.searchStations(value);
              setState(() {
                stations = response;
              });
            },
          ),
          for (final station in stations) stationCard(station: station)
        ],
      ),
    );
  }

  Widget stationCard({required Station station}) {
    return GestureDetector(
      onTap: () => Navigator.pop<Station>(context, station),
      child: ListTile(
        title: Text(station.nomeBreve),
      ),
    );
  }
}
