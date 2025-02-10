import 'package:flutter/material.dart'; // Lo que nos va a permitir crear la interfaz.
import 'package:file_picker/file_picker.dart'; // Paquete que nos permite seleccionar archivos desde el dispositivo.

// Nuestra función principal que iniciara la aplicación.
void main() {
  runApp(MyApp()); // Inicia la app llamando al widget MyApp.
}

// Widget MyApp principal.
class MyApp extends StatelessWidget {
  // Widget no cambia de estado.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Esta es la estructura base de la app.
      title: 'Analizador de Hojas de Vida',
      home: PantallaSubirCV(), // Esta es la pantalla principal(inicial).
    );
  }
}

class PantallaSubirCV extends StatefulWidget {
  // Widget si cambia de estado.
  @override
  // Este es el estado asociado al widget PantallaSubirCV.
  PantallaSubirCVState createState() => PantallaSubirCVState();
}

class PantallaSubirCVState extends State<PantallaSubirCV> {
  String? filePath; // Nos guarda el nombre del archivo seleccionado.
  Map<String, String> datosCV = {
    // Nos da un mapa que simula la información extraída de la hoja de vida.
    // Estos son ejemplo de lo que la IA debería obtener de los archivos.
    'Nombre completo': 'Pepita erez',
    'Telefono': '23902945',
    'Email': 'pepita@gmaol.com',
    'Experiencia': '6 años en desarrollo de videojuegos',
    'Educación': 'Ingeniería en Sistemas en Universidad Eafit',
    'Habilidades': 'Liderazgo, comunicación'
  };

  Future<void> pickFile() async {
    // Nos permite abrir el explorador de archivos.
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        // Actualiza la pantalla con el archivo seleccionado.
        filePath = result.files.single.name; // Cambia el estado
      });
    }
  }

  void analizarCV() {
    Navigator.push(
      // Cambia a la pantalla PantallaAnalizarCV (donde estará la info extraida).
      context,
      MaterialPageRoute(
        // Envía los datos extraídos al análisis.
        builder: (context) => PantallaAnalizarCV(extractedData: datosCV),
      ),
    );
  }

// Interfaz para pantalla donde se sube el archivo.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Nos da la barra superior y el cuerpo.
      appBar: AppBar(
        title: Text('Análisis inteligente de Hojas de Vida'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              // Nuestro botón de seleccionar un archivo.
              onPressed: pickFile,
              child: Text('Seleccionar archivo'),
            ),
            SizedBox(height: 30), // Este es el espacio entre widgets.
            if (filePath != null)
              Text('Archivo: $filePath'), // Muestra el archivo seleccionado.
            SizedBox(height: 30), // Este es el espacio entre widgets.
            ElevatedButton(
              onPressed: filePath != null
                  ? analizarCV
                  : null, // analizarCV nos lleva a la pantalla de análisis.
              child: Text('Análizar hoja de vida'),
            ),
          ],
        ),
      ),
    );
  }
}

class PantallaAnalizarCV extends StatefulWidget {
  // StatefulWidget nos permite editar la info del CV.
  final Map<String, String>
      extractedData; // Recibimos los datos extraídos del CV.

  PantallaAnalizarCV({required this.extractedData});

  @override
  PantallaAnalizarCVState createState() => PantallaAnalizarCVState();
}

class PantallaAnalizarCVState extends State<PantallaAnalizarCV> {
  late Map<String, TextEditingController> controllers;
  // TextEditingController nos permite que los campos sean editables(nombre, telefono, etc.).
  @override
  void initState() {
    super.initState();
    controllers = widget.extractedData.map(
      (key, value) => MapEntry(key, TextEditingController(text: value)),
    );
  }

// Construcción de la interfaz para análizar la hoja de vida.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Resultado del análisis')),
      body: Padding(
        padding: EdgeInsets.all(16.0), // Agrega 16 píxeles en todos los lados.
        child: Column(
          children: [
            Expanded(
              child: ListView(
                // Muestra los datos de una lista.
                children: controllers.entries.map((entry) {
                  // Obtiene todas las claves-valores y recorre cada par
                  // clave-valor del mapa y crea un TextField para cada campo.
                  return TextField(
                    // Nos deja editar la info.
                    controller: entry.value,
                    decoration: InputDecoration(
                        labelText:
                            entry.key), // Muestra "nombre".. como etiqueta.
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                    context); // Con esto regresamos a la pantalla anterior(subirCV).
              },
              child: Text('Guardar cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
