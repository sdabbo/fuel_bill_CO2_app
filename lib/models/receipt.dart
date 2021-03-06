import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ReceiptModel {
  final XFile _file;
  bool _testingData = false;

  void Function() _callbackNotifyFunction;
  bool _calculating = true;
  bool _failed = false;
  String _type;
  double _amount;
  double _gallons;
  DateTime _dateTime;

  var test = Random().nextInt(45);

  ReceiptModel(this._file, void Function() notify) {
    _callbackNotifyFunction = notify;
    _dateTime = DateTime.now();
    _getData();
    print(_file.path);
  }

  ReceiptModel.n(DateTime dateTime, this._file, void Function() notify) {
    _callbackNotifyFunction = notify;
    _calculating = false;
    double gallons = Random().nextDouble() * 25;
    _gallons = gallons;
    _amount = gallons * (Random().nextDouble() * 4);
    _type = Random().nextBool() ? 'diesel' : 'petrol';
    _dateTime = dateTime;
    _testingData = true;
  }

  String get path => _file?.path;

  bool get testingData => _testingData;

  bool get calculating => _calculating;

  bool get failed => _failed;

  double get price => double.parse((_amount).toStringAsFixed(2));

  double get gallons => double.parse((_gallons).toStringAsFixed(2));

  String get fuelTypeShort => _type.toLowerCase() == "diesel" ? "D" : "P";

  DateTime get dateTime => _dateTime;

  double get emissions => double.parse((_getCO2Value()).toStringAsFixed(2));

  double get pricePerLiter =>
      double.parse((_amount / _gallons).toStringAsFixed(2));

  double _getCO2Value() {
    double co2KG = 0;
    switch (_type.toLowerCase()) {
      case "diesel":
        co2KG = 10.1746899767; //2.68787 * 3.78541
        break;
      case "petrol":
      case "petro":
      case "petro1":
      case "petrol1":
        co2KG = 8.2068445882; //2.16802 * 3.78541
        break;
    }
    return co2KG * _gallons;
  }

  Future _getData() async {
    final File imageFile = File(_file.path);
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(imageFile);
    final TextRecognizer textRecognizer =
        FirebaseVision.instance.textRecognizer();
    final VisionText visionText =
        await textRecognizer.processImage(visionImage);

    _parseData(visionText.blocks);

    textRecognizer.close();
  }

  void _parseData(List<TextBlock> blocks) {
    try {
      _extractGallons(blocks);
      _extractAmount(blocks);
      _extractType(blocks);
      _calculating = false;
      _callbackNotifyFunction();
    } catch (e) {
      _failed = true;
      _callbackNotifyFunction();

      for (TextBlock block in blocks) {
        print("__________DEBUG_______");
        print(block.text);
      }
    }
  }

  void _extractGallons(List<TextBlock> blocks) {
    print("____EXTRACT_GALLONS______");
    _gallons =
        double.parse(_extractValue(blocks, "GALLONS|GADLONS|LLONS|GALLON"));
    print("_gallons: ${_gallons}");
  }

  void _extractAmount(List<TextBlock> blocks) {
    print("____EXTRACT_AMOUNT______");
    _amount = double.parse(_extractValue(blocks,
        "FUEL SALE|FOBL SALE|FUELS|FUESAUE|FUBL SADE|FOELS SALE|FUEL SAuE|FUBL SALE"));
    print("_amount: ${_amount}");
  }

  void _extractType(List<TextBlock> blocks) {
    print("____EXTRACT_TYPE______");
    _type = _extractValue(blocks, "PRODUCT");
    print("_type: ${_type}");
  }

  String _extractValue(List<TextBlock> blocks, String regex) {
    bool found = false;
    for (TextBlock block in blocks) {
      if (found == true) {
        print("FOUND");
        print(block.text);
        return block.text
            .replaceAll('. ', '.')
            .split(' ')
            .last
            .replaceAll('\$', '')
            .replaceAll(':', '')
            .replaceAll(RegExp(r'[a-zA-Z]'), '')
            .replaceAll('..', '.');
      }

      if (block.text.startsWith(RegExp(regex))) {
        print(block.text);
        //Products type is sometimes found in same block as 'PRODUCT:'
        if (block.text.startsWith("PRODUCT")) {
          String lastPart = block.text.split(' ').last;
          if (!lastPart.contains(RegExp(regex))) {
            print("IN SAME BLOCK");
            return lastPart.replaceAll('\$', '').replaceAll(':', '');
          }
        }

        found = true;
      }
    }
  }
}
