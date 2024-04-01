import 'package:binario_m/pages/home.dart';
import 'package:binario_m/providers/recently_solutions.dart';
import 'package:binario_m/providers/theme.dart';
import 'package:binario_m/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorage.db = await LocalStorage.initDb();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => RecentlySolutionsProvider())
    ],
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
