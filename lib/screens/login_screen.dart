import 'package:flutter/material.dart';
import 'package:n3ds_taller/screens/register_screen.dart';
import 'package:n3ds_taller/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginForm(),
              SizedBox(height: 48),
              TextButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                ),
                child: Text("No tienes cuenta? Registrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
