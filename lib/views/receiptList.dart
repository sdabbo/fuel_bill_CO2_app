import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/receipts.dart';
import 'package:my_app/views/camera/takePicture.dart';
import 'package:my_app/views/home.dart';
import 'package:my_app/views/navigation.dart';
import 'package:my_app/views/receipt.dart';
import 'package:provider/provider.dart';

class ReceiptList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Consumer<ReceiptsModel>(builder: (context, receipts, child) {
      return receipts.length == 0
          ? Center(
              child: Text('No receipts yet. Start scanning!'),
            )
          : ListView(
              children: receipts.itemsReversed.asMap().entries.map((receipt) {
                return Receipt(
                  receipt: receipt.value,
                  number: (receipts.length - receipt.key),
                );
              }).toList(),
            );
    });
  }
}
