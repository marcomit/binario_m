import 'package:binario_m/models/station.dart';
import 'package:binario_m/utils/viaggia_treno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Station> _stations = [];
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        TextField(
          controller: _searchController,
          onChanged: (value) async {
            _stations = await ViaggiaTreno.searchStations(value);
          },
        ),
        ListView.builder(
            itemCount: _stations.length,
            itemBuilder: (ctx, index) => Text(_stations[index].nomeLungo))
      ],
    ));
  }
}
