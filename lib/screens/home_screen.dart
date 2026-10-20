import 'package:flutter/material.dart';
import 'package:n3ds_taller/screens/destinos_screens.dart';
import 'package:n3ds_taller/screens/mis_destinos_screen.dart';
import 'package:n3ds_taller/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) {
          setState(() => _currentIndex = value);
        },
        selectedIndex: _currentIndex,
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: "Inicio"),
          NavigationDestination(
            icon: Icon(Icons.gps_fixed),
            label: "Mis Destinos",
          ),
          NavigationDestination(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
      body: <Widget>[
        DestinosScreens(),
        MisDestinosScreen(),
        ProfileScreen(),
      ][_currentIndex],
    );
  }
}
