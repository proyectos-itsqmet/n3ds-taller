import 'package:flutter/material.dart';
import 'package:n3ds_taller/screens/home_screen.dart';
import 'package:n3ds_taller/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _auth = AuthService();
  final _correoElectronico = TextEditingController();
  final _contrasenia = TextEditingController();

  bool _cargando = false;

  Future iniciar() async {
    setState(() => _cargando = true);

    try {
      await _auth.iniciarSesion(
        correoElectronico: _correoElectronico.text.trim(),
        contrasenia: _contrasenia.text.trim(),
      );

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } on AuthException catch (e) {
      print(e);
    } finally {
      if (mounted) setState(() => _cargando = false);
    }
  }

  @override
  void dispose() {
    _correoElectronico.dispose();
    _contrasenia.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("TravelWeather", style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: 48),
        Text(
          "Correo electronico",
          style: Theme.of(context).textTheme.labelSmall,
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: _correoElectronico,
          decoration: InputDecoration(
            hintText: "Correo electronico",
            border: OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        SizedBox(height: 24),
        Text("Contaseña", style: Theme.of(context).textTheme.labelSmall),
        SizedBox(height: 8),
        TextFormField(
          controller: _contrasenia,
          decoration: InputDecoration(
            hintText: "Contraseña",
            border: OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        SizedBox(height: 24),
        SizedBox(
          height: 50,
          width: double.infinity,
          child: FilledButton(
            onPressed: _cargando ? null : () => iniciar(),
            child: Text("Iniciar"),
          ),
        ),
      ],
    );
  }
}
