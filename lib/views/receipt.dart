import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/receipt.dart';
import 'package:my_app/views/camera/takePicture.dart';
import 'package:my_app/views/home.dart';
import 'package:my_app/views/navigation.dart';
import 'package:intl/intl.dart';import 'package:timeago/timeago.dart' as timeago;


class Receipt extends StatelessWidget {
  final oCcy = new NumberFormat("#,##0.00", "en_US");

  Receipt({
    Key key,
    this.receipt,
    this.number,
  }) : super(key: key);

  final ReceiptModel receipt;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(64, 75, 96, .9),
        ),
        child: ListTile(
          contentPadding:
          EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
              border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24),
              ),
            ),
            child: receipt.testingData
                ? new Image.asset('assets/receipt.png')
                : new Image.file(
              File(receipt.path),
              fit: BoxFit.cover,
              height: 300.0,
            ),
          ),
          title: Text(
            "Refuel ${timeago.format(receipt.dateTime)}",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),

          subtitle: Column(
            children: [
              Row(
                children: <Widget>[
                  Icon(Icons.filter_drama, color: Colors.red.shade400),
                  Text(
                    " ${receipt.emissions.toString()} kg CO2e",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.local_gas_station, color: Colors.white),
                  Text(
                    " ${receipt.gallons.toString()} gallons",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.payments, color: Colors.white),
                  Text(
                    " \$ ${receipt.pricePerLiter.toString()} / gallon",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ],
          ),
          trailing: Text(receipt.fuelTypeShort,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 50.0,
            ),
          ),
        ),
      ),
    );
  }
}