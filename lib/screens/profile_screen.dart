import 'package:flutter/material.dart';
import 'package:n3ds_taller/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? usuario = AuthService().usuario;

    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
        child: usuario != null
            ? ListView(children: [Text(usuario.email!)])
            : Center(child: Text("No hay datos del usuario")),
      ),
    );
  }
}
