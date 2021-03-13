import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:my_app/camera/displayPicture.dart';
import 'package:my_app/camera/takePicture.dart';
import 'package:my_app/home.dart';

class Overview extends StatefulWidget {
  final List<CameraDescription> cameras;

  const Overview({
    Key key,
    @required List<CameraDescription> this.cameras,
  }) : super(key: key);

  @override
  OverviewState createState() => OverviewState();
}

class OverviewState extends State<Overview> {
  int _selectedIndex = 0;

  List<XFile> images;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('C02 App'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
          child: _selectedIndex == 0
              ? HomeScreen(cameras: widget.cameras)
              :
          Placeholder()),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        backgroundColor: Colors.blueGrey,
        onTap: _onItemTapped,
      ),
    );
  }
}
/*
TakePictureScreen(
                  cameras: widget.cameras,
                )),
 */
/*
floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();

            // If the picture was taken, display it on a new screen.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  // Pass the automatically generated path to
                  // the DisplayPictureScreen widget.
                  imagePath: image?.path,
                ),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
 */
