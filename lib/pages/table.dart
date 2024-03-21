import 'package:binario_m/models/station.dart';
import 'package:binario_m/models/train_stop.dart';
import 'package:binario_m/utils/global.dart';
import 'package:binario_m/utils/viaggia_treno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TablePage extends StatefulWidget {
  final Station station;
  const TablePage({super.key, required this.station});

  @override
  State<TablePage> createState() => _TablePageState();
}

enum TableType { arrivals, departures }

class _TablePageState extends State<TablePage> {
  final PageController _pageController = PageController();
  String _currentTab = '0';
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.station.nomeBreve),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: CupertinoSlidingSegmentedControl(
                padding: const EdgeInsets.all(5),
                groupValue: _currentTab,
                children: const {
                  '0': Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Text('Partenze'),
                  ),
                  '1': Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Text('Arrivi'),
                  ),
                },
                onValueChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _currentTab = value;
                  });
                  _pageController.jumpTo(value == '0' ? 0 : 1);
                }),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 150,
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  _currentTab = value == 0 ? '0' : '1';
                });
              },
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              itemCount: 2,
              itemBuilder: (context, index) =>
                  index == 0 ? departureList() : arrivalList(),
            ),
          ),
        ],
      ), /*PageView.builder(
        controller: _pageController,
        itemCount: 2,
        itemBuilder: (context, index) =>
            index == 0 ? departureList() : arrivalList(),
      ),*/
    );
  }

  Widget departureList() => FutureBuilder(
      future: ViaggiaTreno.getTable(widget.station),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (snapshot.hasData) {
          return routesList(snapshot.data as List<TrainRoute>);
        }
        return const Center(child: CircularProgressIndicator());
      }));

  Widget arrivalList() => FutureBuilder(
      future: ViaggiaTreno.getTable(widget.station),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (snapshot.hasData) {
          return routesList(snapshot.data as List<TrainRoute>);
        }
        return const Center(child: CircularProgressIndicator());
      }));

  Widget routesList(List<TrainRoute> routes) => ListView.builder(
      itemCount: routes.length,
      itemBuilder: (context, index) => Card(
          child: Container(
              padding: const EdgeInsets.all(10),
              height: 50,
              child: Row(children: [
                Text("${routes[index].numeroTreno}${routes[index].categoria!}"),
                const SizedBox(width: 10),
                Text(replaceOn(routes[index].origine, null, "")),
                const Spacer(),
                Text(replaceOn(routes[index].compOrarioPartenza, null, "tr")),
              ]))));
}
