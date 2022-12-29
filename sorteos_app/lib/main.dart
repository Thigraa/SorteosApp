import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sorteos_app/screens/add_screen.dart';
import 'package:sorteos_app/screens/home_page.dart';
import 'package:sorteos_app/screens/raffle_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'helpers/notifications_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('en', 'UK'),
        const Locale('es', 'ES'),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScreen(),
        'add': (_) => AddScreen(),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light().copyWith(
          primaryColor: Colors.deepPurple.shade400,
          accentColor: Colors.deepPurple,
          dialogTheme: DialogTheme(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)))),
    );
  }
}
