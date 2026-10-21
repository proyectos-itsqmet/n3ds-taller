import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:n3ds_taller/services/auth_service.dart';
import 'package:n3ds_taller/widgets/item_list.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();

    final User? usuario = AuthService().usuario;

    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
        child: usuario != null
            ? ListView(
                children: [
                  SizedBox(height: 24),
                  CircleAvatar(
                    maxRadius: 50,
                    child: Icon(Icons.person, size: 50),
                  ),
                  SizedBox(height: 12),
                  Text(
                    usuario.userMetadata?['nombre'],
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 48),
                  Text(
                    "Información del usuario",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  ItemList(
                    title: "Registrado desde:",
                    text: DateFormat(
                      'yyyy/MM/dd',
                    ).format(DateTime.parse(usuario.updatedAt!)),
                  ),
                  Divider(),
                  ItemList(title: "Correo electronico:", text: usuario.email!),
                  Divider(),
                  ItemList(title: "Telefono:", text: usuario.phone!),
                  SizedBox(height: 64),
                  Center(
                    child: OutlinedButton(
                      onPressed: () => auth.cerrarSesion(context),
                      child: Text("Cerrar sesión"),
                    ),
                  ),
                ],
              )
            : Center(child: Text("No hay datos del usuario")),
      ),
    );
  }
}
