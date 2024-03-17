import 'package:binario_m/pages/home.dart';
import 'package:binario_m/providers/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
    child: const Main(),
  ));
  
}

class Main extends StatelessWidget {
  const Main({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Binario M',
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: context.watch<ThemeProvider>().themeMode,
      home: const HomePage(),
    );
  }
}

