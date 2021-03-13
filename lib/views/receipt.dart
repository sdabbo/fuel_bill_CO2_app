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
import 'package:intl/intl.dart';

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
    return ListTile(
      leading: new Image.file(
        File(receipt.path),
        fit: BoxFit.cover,
        height: 300.0,
      ),
      title: new Text(
        '${receipt.emissions.toString()} Kg CO2',
        style: new TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          color: Colors.redAccent,
        ),
      ),
      subtitle: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text('${receipt.gallons.toString()} gallons',
                style: new TextStyle(
                    fontSize: 13.0, fontWeight: FontWeight.normal)),
            new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new Text(
                    'Price / Liter: \$${oCcy.format(receipt.pricePerLiter)}',
                    style: new TextStyle(
                        fontSize: 11.0, fontWeight: FontWeight.normal)),
                new Text(
                    'On: ${DateFormat('yyyy-MM-dd').format(receipt.dateTime)}',
                    style: new TextStyle(
                        fontSize: 11.0, fontWeight: FontWeight.normal)),
              ],
            )
          ]),
    );
  }
}

/*
Column(
mainAxisAlignment: MainAxisAlignment.end,
children: [
Padding(
padding: const EdgeInsets.only(bottom: 8.0),
child: Text(
"Receipt #" + number.toString(),
style: TextStyle(color: Colors.black54),
),
),
Image.file(
File(receipt.path),
fit: BoxFit.cover,
),
Divider(
color: Colors.blueGrey,
),
],
);
 */
