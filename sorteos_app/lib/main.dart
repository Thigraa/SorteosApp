import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sorteos_app/screens/add_screen.dart';
import 'package:sorteos_app/screens/home_page.dart';
import 'package:sorteos_app/screens/raffle_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScreen(),
        'add': (_) => AddScreen(),
      },
      theme: ThemeData.light()
          .copyWith(colorScheme: ColorScheme.highContrastLight()),
    );
  }
}
