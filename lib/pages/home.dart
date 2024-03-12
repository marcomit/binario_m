import 'package:binario_m/models/station.dart';
import 'package:binario_m/pages/search.dart';
import 'package:binario_m/pages/solutions.dart';
import 'package:binario_m/utils/viaggia_treno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Station partenza;
  late Station destinazione;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Trains")),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const SearchPage()))
                    .then((value) {
                  if (value is Station) {
                    setState(() {
                      partenza = value;
                    });
                  }
                });
              },
              child: const Text('Partenza')),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const SearchPage()))
                    .then((value) {
                  if (value is Station) {
                    setState(() {
                      destinazione = value;
                    });
                  }
                });
              },
              child: const Text('Arrivo'))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async => ViaggiaTreno.searchStations("manzi"),
          child: const Icon(CupertinoIcons.add)),
    );
  }
}
