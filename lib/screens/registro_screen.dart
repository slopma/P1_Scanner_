import 'package:flutter/material.dart';
import '../data_base/database_helper.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  RegistroScreenState createState() => RegistroScreenState();
}

class RegistroScreenState extends State<RegistroScreen> {
  final _formKey = GlobalKey<FormState>();
  String _nombre = '';
  String _email = '';
  String _password = '';

  Future<void> _registrarUsuario() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Verificar si el correo ya está registrado
      final usuarioExistente = await DatabaseHelper.instance.obtenerUsuarioPorEmail(_email);
      if (usuarioExistente != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('El correo ya está registrado')),
        );
        return;
      }

      // Guardar usuario en SQLite
      await DatabaseHelper.instance.agregarUsuario(_nombre, _email, _password);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario registrado correctamente')),
      );

      Navigator.pop(context); // Regresa al login
    }
  }

  bool _validarPassword(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) => value!.isEmpty ? 'Ingrese su nombre' : null,
                onSaved: (value) => _nombre = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                value!.isEmpty || !value.contains('@') ? 'Ingrese un correo válido' : null,
                onSaved: (value) => _email = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) =>
                !_validarPassword(value!)
                    ? 'Debe tener al menos 8 caracteres, una mayúscula, un número y un símbolo'
                    : null,
                onSaved: (value) => _password = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registrarUsuario,
                child: const Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
