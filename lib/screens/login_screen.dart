import 'package:flutter/material.dart';
import '../data_base/database_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  Future<void> _iniciarSesion() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final success = await DatabaseHelper.instance.iniciarSesion(_email, _password);

      if (!mounted) return;

      if (success) {
        await DatabaseHelper.instance.guardarSesion(_email); // Guardar sesión
        Navigator.pushReplacementNamed(context, '/welcome');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credenciales incorrectas')),
        );
      }
    }
  }

  void _recuperarPassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Recuperación de contraseña no implementada aún')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio de Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                autofocus: true, // Esto abrirá el teclado automáticamente en móviles
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value!.isEmpty || !value.contains('@') ? 'Ingrese un correo válido' : null,
                onSaved: (value) => _email = value!,
              ),
              TextFormField(
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Ingrese su contraseña' : null,
                onSaved: (value) => _password = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _iniciarSesion,
                child: const Text('Iniciar Sesión'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/registro');
                },
                child: const Text(
                  'Crear cuenta',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: _recuperarPassword,
                child: const Text(
                  'Olvidé mi contraseña',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
