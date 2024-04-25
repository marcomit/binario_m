import 'package:binario_m/components/themes.dart';
import 'package:binario_m/pages/home.dart';
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
    ],
    child: const Main(),
  ));
}

class Main extends StatelessWidget {
  const Main({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Binario M',
      theme: LightTheme(themeProvider.currentSeedColor),
      darkTheme: DarkTheme(themeProvider.currentSeedColor),
      themeMode: themeProvider.themeMode,
      home: const HomePage(),
    );
  }
}
