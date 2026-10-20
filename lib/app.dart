import 'package:flutter/material.dart';
import 'package:n3ds_taller/screens/login_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TravelWeather',
      theme: ThemeData(colorSchemeSeed: Colors.orange),
      home: LoginScreen(),
    );
  }
}
