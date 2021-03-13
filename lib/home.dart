import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:my_app/camera/takePicture.dart';
import 'package:my_app/navigation.dart';

class HomeScreen extends StatelessWidget {

  final List<CameraDescription> cameras;

  const HomeScreen({
    Key key,
    @required List<CameraDescription> this.cameras,
  }) : super(key: key);

  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('you are on this page'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        // Provide an onPressed callback.
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TakePictureScreen(
                cameras: cameras,
              ),
            ),
          );
        },
      ),
    );
  }
}
