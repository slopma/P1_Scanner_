import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' show File;
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(MyApp()); // incia la app
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // hide  tiqueta debug
      home: HomeScreen(), // pantalla inicial
    );
  }
}

// inicio un botón continuar
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subir mi Hoja de Vida'), // titulo pantalla
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // pantalla selección de opciones
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OptionsScreen()),
            );
          },
          child: Text('Continuar'),
        ),
      ),
    );
  }
}

//selección de opciones
class OptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona una opción'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // pantalla de tomar foto
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TakePhotoScreen()),
                );
              },
              child: Text('Tomar Foto'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // pantalla de cargar archivo
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UploadFileScreen()),
                );
              },
              child: Text('Cargar Archivo'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // pantalla de generar hoja de vida
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GenerateResumeScreen()),
                );
              },
              child: Text('Generar Mi Hoja de Vida'),
            ),
          ],
        ),
      ),
    );
  }
}

// tomar una foto con la cámara
class TakePhotoScreen extends StatefulWidget {
  @override
  _TakePhotoScreenState createState() => _TakePhotoScreenState();
}

class _TakePhotoScreenState extends State<TakePhotoScreen> {
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // guarda imagen 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tomar Foto')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No se ha tomado ninguna foto')
                : Image.file(_image!), // muestra imagen 
            ElevatedButton(
              onPressed: getImage,
              child: Text('Abrir Cámara'),
            ),
          ],
        ),
      ),
    );
  }
}

// cargar un archivo 
class UploadFileScreen extends StatefulWidget {
  @override
  _UploadFileScreenState createState() => _UploadFileScreenState();
}

class _UploadFileScreenState extends State<UploadFileScreen> {
  String? fileName;

  Future pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    
    if (result != null) {
      setState(() {
        fileName = result.files.single.name; // guarda nombre del archivo
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cargar Archivo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: pickFile,
              child: Text('Seleccionar Archivo'),
            ),
            SizedBox(height: 20),
            Text(fileName ?? 'Ningún archivo seleccionado'),
          ],
        ),
      ),
    );
  }
}

// generar una hoja de vida con un formulario
class GenerateResumeScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Generar Hoja de Vida')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nombre'), // nombre
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Correo Electrónico'), // correo
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Teléfono'), // teléfono
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // antalla de éxito
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SuccessScreen()),
                );
              },
              child: Text('Guardar Hoja de Vida'),
            ),
          ],
        ),
      ),
    );
  }
}

// confirmación después de guardar la hoja de vida
class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Éxito')),
      body: Center(
        child: Text('Hoja de Vida guardada con éxito', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
