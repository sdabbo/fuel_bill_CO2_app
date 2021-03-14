import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/receipts.dart';
import 'package:my_app/views/camera/takePicture.dart';
import 'package:my_app/views/home.dart';
import 'package:my_app/views/insigths/insights.dart';

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

  //List<XFile> images = [];

  //ReceiptsModel receiptsModel = ReceiptsModel();

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
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: _selectedIndex == 0 ? Text("My Receipts") : Text("My Statistics"),
      ),
      body: Center(
        child: _selectedIndex == 0
            ? HomeScreen(cameras: widget.cameras)
            : Insights(),
      ),
      bottomNavigationBar: Container(
        height: 55.0,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.insights),
              label: 'Insights',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.white,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}