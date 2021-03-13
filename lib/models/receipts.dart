import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/receipt.dart';

class ReceiptsModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<ReceiptModel> _receipts = [];

  ReceiptsModel() {
    XFile file = XFile('assets/receipt.png');
    _addReceiptModel(ReceiptModel.n(DateTime.now(), file, notify));
    _addReceiptModel(ReceiptModel.n(
        DateTime.now().subtract(Duration(days: 1)), file, notify));
    _addReceiptModel(ReceiptModel.n(
        DateTime.now().subtract(Duration(days: 3)), file, notify));
  }

  int get length => items.length;

  void notify() {
    notifyListeners();
  }

  /// An unmodifiable view of the items in the cart.
  List<ReceiptModel> get items =>
      _receipts.where((e) => !e.calculating).toList();

  List<ReceiptModel> get itemsReversed => _reversedReceipts();

  /// The current total price of all receipts
  double get totalPrice => _receipts
      .map((receipt) => receipt.amount)
      .fold(0, (prev, amount) => prev + amount);

  /// The current total gallons of all receipts
  double get totalGallons => _receipts
      .map((receipt) => receipt.gallons)
      .fold(0, (prev, amount) => prev + amount);

  /// The current total CO2 KG of all receipts
  double get totalCO2KG => _receipts
      .map((receipt) => receipt.emissions)
      .fold(0, (prev, amount) => prev + amount);

  /// Is any one calculating
  bool get anyCalculating =>_receipts.where((element) => element.calculating).length > 0;


  List<ReceiptModel> _reversedReceipts() {
    Iterable inReverse = items.reversed;
    return inReverse.toList();
  }

  /// Adds [receipt] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(XFile file) {
    _receipts.add(ReceiptModel(file, notify));
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void _addReceiptModel(ReceiptModel receiptModel) {
    _receipts.add(receiptModel);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
