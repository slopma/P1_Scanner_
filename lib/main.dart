import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://zpprbzujtziokfyyhlfa.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpwcHJienVqdHppb2tmeXlobGZhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDA3ODAyNzgsImV4cCI6MjA1NjM1NjI3OH0.cVRK3Ffrkjk7M4peHsiPPpv_cmXwpX859Ii49hohSLk',
  );
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AudioRecorderScreen(),
  ));
}

final supabase = Supabase.instance.client;

class AudioRecorderScreen extends StatefulWidget {
  const AudioRecorderScreen({super.key});

  @override
  _AudioRecorderScreenState createState() => _AudioRecorderScreenState();
}

class _AudioRecorderScreenState extends State<AudioRecorderScreen> {
  final Record _audioRecorder = Record();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isRecording = false;
  String? _audioBlobUrl;
  Uint8List? _audioBytes;
  String? _audioSupabaseUrl; // URL en Supabase

  Future<void> _startRecording() async {
    try {
      bool hasPermission = await _audioRecorder.hasPermission();
      if (hasPermission) {
        await _audioRecorder.start();
        setState(() {
          _isRecording = true;
        });
      }
    } catch (e) {
      print("Error al iniciar grabación: $e");
    }
  }

  Future<void> _stopRecording() async {
    try {
      String? path = await _audioRecorder.stop();
      if (path != null) {
        setState(() {
          _isRecording = false;
          _audioBlobUrl = path; // Flutter Web devuelve un Blob URL
        });

        // Convertimos el Blob en bytes para subirlo a Supabase
        await _convertBlobToBytesAndUpload(path);
      }
    } catch (e) {
      print("Error al detener grabación: $e");
    }
  }

  Future<void> _convertBlobToBytesAndUpload(String blobUrl) async {
    try {
      final response = await html.HttpRequest.request(
        blobUrl,
        responseType: 'arraybuffer',
      );

      if (response.response is ByteBuffer) {
        _audioBytes = Uint8List.view(response.response as ByteBuffer);

        // Subimos el archivo a Supabase
        await _uploadAudioToSupabase();
      }
    } catch (e) {
      print("Error al convertir Blob a bytes: $e");
    }
  }

  Future<void> _uploadAudioToSupabase() async {
    if (_audioBytes == null) return;

    try {
      final fileName = 'audio_${DateTime.now().millisecondsSinceEpoch}.webm';
      final response = await supabase.storage
          .from('Audios')
          .uploadBinary(fileName, _audioBytes!,
              fileOptions: const FileOptions(contentType: 'audio/webm'));

      if (response.isNotEmpty) {
        _audioSupabaseUrl = supabase.storage.from('Audios').getPublicUrl(fileName);
        setState(() {});
        print("Archivo subido a Supabase: $_audioSupabaseUrl");
      }
    } catch (e) {
      print("Error al subir el audio a Supabase: $e");
    }
  }

  Future<void> _playRecording() async {
    if (_audioSupabaseUrl != null) {
      await _audioPlayer.play(UrlSource(_audioSupabaseUrl!));
    } else if (_audioBlobUrl != null) {
      await _audioPlayer.play(UrlSource(_audioBlobUrl!));
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
        title: Text('Grabar y Reproducir Audio'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _isRecording ? Text('Grabando...') : Text('Presiona el botón para grabar'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              child: Text(_isRecording ? 'Detener Grabación' : 'Comenzar Grabación'),
            ),
            SizedBox(height: 20),
            if (_audioBlobUrl != null || _audioSupabaseUrl != null)
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
