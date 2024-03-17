import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TableTab extends StatefulWidget {
  const TableTab({super.key});

  @override
  State<TableTab> createState() => _TableTabState();
}

enum TableTabType { arrivals, departures }

class _TableTabState extends State<TableTab> {
  TableTabType _type = TableTabType.departures;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: Column(
        children: [
          Center(
            child: CupertinoSlidingSegmentedControl(
                padding: const EdgeInsets.all(5),
                groupValue: _type,
                children: const {
                  TableTabType.departures: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Partenze',
                      style: TextStyle(color: CupertinoColors.white),
                    ),
                  ),
                  TableTabType.arrivals: Padding(
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
    );
  }
}
