import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/receipts.dart';
import 'package:my_app/views/camera/takePicture.dart';
import 'package:my_app/views/navigation.dart';
import 'package:my_app/views/receiptList.dart';

class HomeScreen extends StatelessWidget {

  final List<CameraDescription> cameras;

  const HomeScreen({
    Key key,
    @required List<CameraDescription> this.cameras,
  }) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    //ReceiptsModel receipts = context.findAncestorStateOfType<OverviewState>().receiptsModel;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ReceiptList(),),
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
