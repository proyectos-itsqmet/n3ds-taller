import 'package:flutter/material.dart';
import 'package:n3ds_taller/screens/login_screen.dart';
import 'package:n3ds_taller/widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
              RegisterForm(),
              SizedBox(height: 48),
              TextButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                ),
                child: Text("Ya tienes cuenta? Ingresa"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
