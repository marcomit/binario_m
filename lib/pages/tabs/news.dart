import 'package:binario_m/utils/viaggia_treno.dart';
import 'package:flutter/material.dart';

class NewsTab extends StatefulWidget {
  const NewsTab({super.key});

  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  int _refreshIndex = 0;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => setState(() => _refreshIndex++),
      child: FutureBuilder(
          future: ViaggiaTreno.getNews(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Errore durante il recupero delle notizie'),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    style: ListTileStyle.drawer,
                    title: Text(
                      snapshot.data![index].title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(snapshot.data![index].text),
                  );
                },
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return Text("loading");
          }),
    );
  }
}
