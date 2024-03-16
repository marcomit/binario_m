import 'package:flutter/material.dart';

import '../models/station.dart';

class TrainDetailsPage extends StatefulWidget {
  final Station departure;
  final Station destination;
  const TrainDetailsPage(
      {super.key, required this.departure, required this.destination});

  @override
  State<TrainDetailsPage> createState() => _TrainDetailsPageState();
}

class _TrainDetailsPageState extends State<TrainDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Treni'),
      ),
    );
  }
}
