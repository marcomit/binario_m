import 'package:binario_m/models/solution.dart';
import 'package:binario_m/models/station.dart';
import 'package:binario_m/utils/global.dart';
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
        itemBuilder: (context, index) {
          final solution = widget.solutions[index];
          return solutionCard(solution);
        },
      ),
    );
  }

  Widget solutionCard(Solution solution) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final vehicle in solution.vehicles)
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                          '${formatNumber(vehicle.orarioPartenza.hour)}:${formatNumber(vehicle.orarioPartenza.minute)}'),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(vehicle.origine)
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                          '${formatNumber(vehicle.orarioArrivo.hour)}:${formatNumber(vehicle.orarioArrivo.minute)}'),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(vehicle.destinazione)
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            const SizedBox(height: 20),
            Text(
                '${formatNumber(solution.duration.inHours)}:${formatNumber(solution.duration.inMinutes)}')
          ],
        ),
      ),
    );
  }
}
