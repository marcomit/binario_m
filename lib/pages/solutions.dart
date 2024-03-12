import 'package:binario_m/models/solution.dart';
import 'package:binario_m/models/station.dart';
import 'package:flutter/material.dart';

class SolutionsPage extends StatefulWidget {
  final Station departure;
  final Station destination;
  final DateTime date;
  final List<Solution> solutions;
  const SolutionsPage(
      {super.key,
      required this.solutions,
      required this.date,
      required this.destination,
      required this.departure});

  @override
  State<SolutionsPage> createState() => _SolutionsPageState();
}

class _SolutionsPageState extends State<SolutionsPage> {
  List<Solution> solutions = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Soluzioni')),
      body: ListView.builder(
        itemCount: widget.solutions.length,
        itemBuilder: (context, index) => Card(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
              leading: Text(widget.solutions[index].vehicles.length.toString()),
              title: Text(widget.solutions[index].durata.inMinutes.toString())),
        )),
      ),
    );
  }
}
