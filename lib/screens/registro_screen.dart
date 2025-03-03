import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_screen.dart';

class RegistroScreen extends StatefulWidget {
  @override
  _RegistroScreenState createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _supabase = Supabase.instance.client;

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> registrarUsuario() async {
    final correo = correoController.text.trim();
    final password = passwordController.text.trim();
    final nombre = nombreController.text.trim();
    final apellido = apellidoController.text.trim();

    try {
      final response = await _supabase.auth.signUp(email: correo, password: password);

      if (response.user != null) {
        final userId = response.user!.id;

        await _supabase.from('usuarios').insert({
          'id': userId,
          'nombre_usuario': nombre,
          'apellido_usuario': apellido,
          'correo': correo,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuario registrado correctamente')),
        );

        // ✅ Redirigir a la pantalla de bienvenida después del registro
        Navigator.pushReplacementNamed(context, '/welcome');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar usuario')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registro de Usuario")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nombreController, decoration: InputDecoration(labelText: "Nombre")),
            TextField(controller: apellidoController, decoration: InputDecoration(labelText: "Apellido")),
            TextField(controller: correoController, decoration: InputDecoration(labelText: "Correo Electrónico")),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: "Contraseña"), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: registrarUsuario, child: Text("Registrar")),
          ],
        ),
      ),
    );
  }
}
