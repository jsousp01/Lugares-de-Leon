import 'package:aplicacion1/src/pages/favorites_page.dart';
import 'package:aplicacion1/src/pages/home_page.dart';
import 'package:aplicacion1/src/share_prefs/user_preferences.dart';
import 'package:flutter/material.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final prefs = UserPreferences();
  await prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Componentes App',
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (BuildContext context) => HomePage(),
        FavoritesPage.routeName: (BuildContext context) => FavoritesPage(),
      },
    );
  }
}