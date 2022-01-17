import 'package:flutter/material.dart';
import 'package:painter_image/camera.dart';
import 'package:painter_image/painter_image.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CameraPage(),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.amberAccent,
            child: const Icon(Icons.camera_alt_sharp),
          ),
        ),
      ),
    );
  }
}
