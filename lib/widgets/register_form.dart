import 'package:flutter/material.dart';
import 'package:n3ds_taller/screens/home_screen.dart';
import 'package:n3ds_taller/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _auth = AuthService();
  final _correoElectronico = TextEditingController();
  final _contrasenia = TextEditingController();
  final _nombreCompleto = TextEditingController();

  bool _cargando = false;

  Future enviar() async {
    setState(() => _cargando = true);

    try {
      await _auth.registrar(
        correoElectronico: _correoElectronico.text.trim(),
        contrasenia: _contrasenia.text.trim(),
        nombreCompleto: _nombreCompleto.text.trim(),
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
    _nombreCompleto.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Registrarse", style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: 48),
        Text("Nombre completo", style: Theme.of(context).textTheme.labelSmall),
        SizedBox(height: 8),
        TextFormField(
          controller: _nombreCompleto,
          decoration: InputDecoration(
            hintText: "Nombre y Apellido",
            border: OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        SizedBox(height: 24),
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
            onPressed: _cargando ? null : () => enviar(),
            child: Text("Registrar"),
          ),
        ),
      ],
    );
  }
}
