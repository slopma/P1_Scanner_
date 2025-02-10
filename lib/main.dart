import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioRecorderScreen extends StatefulWidget {
  @override
  _AudioRecorderScreenState createState() => _AudioRecorderScreenState();
}

class _AudioRecorderScreenState extends State<AudioRecorderScreen> {
  final Record _audioRecorder = Record();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isRecording = false;
  String? _audioPath;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _startRecording() async {
    try {
      // Verifica si el dispositivo tiene permiso para grabar
      bool hasPermission = await _audioRecorder.hasPermission();
      if (hasPermission) {
        // Empieza la grabación
        String filePath = '/tmp/audio_recording.wav'; // Ruta en la web
        await _audioRecorder.start(path: filePath);
        setState(() {
          _isRecording = true;
          _audioPath = filePath;
        });
      }
    } catch (e) {
      print("Error starting recording: $e");
    }
  }

  Future<void> _stopRecording() async {
    try {
      // Detiene la grabación y guarda el archivo
      String? path = await _audioRecorder.stop();
      setState(() {
        _isRecording = false;
        _audioPath = path;
      });
    } catch (e) {
      print("Error stopping recording: $e");
    }
  }

  Future<void> _playRecording() async {
    if (_audioPath != null) {
      // Reproduce la grabación
      await _audioPlayer.play(_audioPath!);  // Aquí ya no usamos DeviceFileSource
    }
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grabar Audio'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _isRecording
                ? Text('Grabando...')
                : Text('Presiona el botón para grabar'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              child: Text(_isRecording ? 'Detener Grabación' : 'Comenzar Grabación'),
            ),
            SizedBox(height: 20),
            if (_audioPath != null)
              ElevatedButton(
                onPressed: _playRecording,
                child: Text('Reproducir Grabación'),
              ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AudioRecorderScreen(),
  ));
}
