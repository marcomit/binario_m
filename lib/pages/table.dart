import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TablePage extends StatefulWidget {
  const TablePage({super.key});

  @override
  State<TablePage> createState() => _TablePageState();
}

enum TableType { arrivals, departures }

class _TablePageState extends State<TablePage> {
  TableType _type = TableType.departures;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabellone'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: Column(
          children: [
            Center(
              child: CupertinoSlidingSegmentedControl(
                  padding: const EdgeInsets.all(5),
                  groupValue: _type,
                  children: const {
                    TableType.departures: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Partenze',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    ),
                    TableType.arrivals: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Arrivi',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    ),
                  },
                  onValueChanged: (value) {
                    if (value == null) return;
                    setState(() => _type = value);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
