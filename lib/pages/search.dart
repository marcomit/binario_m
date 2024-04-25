import 'package:binario_m/components/components.dart';
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
              child: NeuSearchBar(
                hintText: "Cerca una stazione",
                // searchBarColor: Colors.white,
                leadingIcon: const Icon(null),
                onChanged: (value) async {
                  if (value.length < 2) return;
                  setState(() {
                    isLoading = true;
                    isError = false;
                  });
                  final response = await ViaggiaTreno.searchStations(value);
                  if (response == null) {
                    setState(() {
                      isError = true;
                      isLoading = false;
                    });
                    return;
                  }
                  setState(() {
                    stations = response;
                    isLoading = false;
                  });
                },
              ),
            ),
            if (isLoading)
              const Center(
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator())),
            if (isError)
              const Center(
                  child: Text('Errore durante il recupero delle stazioni')),
            for (final station in stations) stationCard(station: station)
          ],
        ));
  }

  Widget stationCard({required Station station}) {
    return GestureDetector(
      onTap: () => Navigator.pop<Station>(context, station),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NeuContainer(
          borderRadius: BorderRadius.circular(10),
          // color: Theme.of(context).scaffoldBackgroundColor,
          child: ListTile(
            title: Text(station.nomeBreve),
            subtitle: Text(station.nomeLungo),
            trailing: Text(station.id),
          ),
        ),
      ),
    );
  }
}
