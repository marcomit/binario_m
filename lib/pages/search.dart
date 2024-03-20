import 'package:binario_m/models/station.dart';
import 'package:binario_m/utils/viaggia_treno.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final String title;
  const SearchPage({super.key, required this.title});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Station> stations = [];
  bool isLoading = false;
  bool isError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: 'Cerca stazione...'),
                onChanged: (value) async {
                  if (value.length < 2) return;
                  setState(() => isLoading = true);
                  final response = await ViaggiaTreno.searchStations(value);
                  setState(() {
                    stations = response;
                    isLoading = false;
                  });
                },
              ),
            ),
            if (isLoading)
              const Center(child: SizedBox(child: CircularProgressIndicator())),
            for (final station in stations) stationCard(station: station)
          ],
        ));
  }

  Widget stationCard({required Station station}) {
    return GestureDetector(
      onTap: () => Navigator.pop<Station>(context, station),
      child: Card(
        child: ListTile(
          title: Text(station.nomeBreve),
          subtitle: Text(station.nomeLungo),
          trailing: Text(station.id),
        ),
      ),
    );
  }
}
