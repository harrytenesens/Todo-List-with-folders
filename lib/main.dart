import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_again/button_blueprints_methods/first_screen_methods.dart';
import 'package:todolist_again/homepage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final firstScreen = FirstScreen();
  await firstScreen.initialize();

  runApp(MultiProvider(
      providers: [ChangeNotifierProvider.value(value: firstScreen)],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
        
  home: const Homepage(),
    );
  }
}
