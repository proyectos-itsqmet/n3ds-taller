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

  Future<void> cerrarSesion() async {
    await _supabase.auth.signOut();
  }

  User? get usuario => _supabase.auth.currentUser;
}
