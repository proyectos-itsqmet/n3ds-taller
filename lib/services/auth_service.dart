import 'package:flutter/material.dart';
import 'package:n3ds_taller/screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final _supabase = Supabase.instance.client;

  Future<AuthResponse> registrar({
    required String correoElectronico,
    required String contrasenia,
    required String nombreCompleto,
  }) async {
    return await _supabase.auth.signUp(
      password: contrasenia,
      email: correoElectronico,
      data: {'nombre': nombreCompleto},
    );
  }

  Future<AuthResponse> iniciarSesion({
    required String correoElectronico,
    required String contrasenia,
  }) async {
    return await _supabase.auth.signInWithPassword(
      password: contrasenia,
      email: correoElectronico,
    );
  }

  Future<void> cerrarSesion(BuildContext context) async {
    await _supabase.auth.signOut();

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  User? get usuario => _supabase.auth.currentUser;
}
