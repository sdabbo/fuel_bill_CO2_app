import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:my_app/camera/takePicture.dart';
import 'package:my_app/navigation.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: Overview(
        cameras: cameras,
      ),
    ),
  );
}



