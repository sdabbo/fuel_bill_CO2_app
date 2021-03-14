import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/receipts.dart';
import 'package:my_app/views/camera/takePicture.dart';
import 'package:my_app/views/navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  List<CameraDescription> cameras;
  if (kIsWeb) {
    cameras = null;
  } else {
    // NOT running on the web!
    // Obtain a list of the available cameras on the device.
    cameras = await availableCameras();
  }

  runApp(App(cameras));
}

/*
  runApp(
    MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: Overview(
        cameras: cameras,
      ),
    ),
  );
 */

class App extends StatelessWidget {
  List<CameraDescription> cameras;

  App(this.cameras);

  String get name => 'foo';

  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(home: Text('Err'));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return ChangeNotifierProvider(
            create: (context) => ReceiptsModel(),
            child: MaterialApp(
              theme: new ThemeData(
                primarySwatch: Colors.cyan,
              ),
              home: Overview(
                cameras: cameras,
              ),
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(home: Text('Loading'));
      },
    );
  }
}
