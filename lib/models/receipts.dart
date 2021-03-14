import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/receipt.dart';

class ReceiptsModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<ReceiptModel> _receipts = [];

  ReceiptsModel() {
    XFile file = XFile('assets/receipt.png');
    _addReceiptModel(ReceiptModel.n(
        DateTime.now().subtract(Duration(days: 25)), file, notify));
    _addReceiptModel(ReceiptModel.n(
        DateTime.now().subtract(Duration(days: 20)), file, notify));
    _addReceiptModel(ReceiptModel.n(DateTime.now().subtract(Duration(days: 7)), file, notify));
  }

  int get length => items.length;

  void notify() {
    notifyListeners();
  }

  /// An unmodifiable view of the items in the cart.
  List<ReceiptModel> get items =>
      _receipts.where((e) => !e.calculating && !e.failed).toList();

  List<ReceiptModel> get itemsReversed => _reversedReceipts();

  /// The current total price of all receipts
  double get totalPrice => double.parse((items
      .map((receipt) => receipt.price)
      .fold(0, (prev, amount) => prev + amount)).toStringAsFixed(2));

  double get totalPriceCurrentYearEstimate => double.parse(_getPriceCurrentYearEstimate().toStringAsFixed(2));

  /// The current total gallons of all receipts
  double get totalGallons => double.parse(items
      .map((receipt) => receipt.gallons)
      .fold(0, (prev, amount) => prev + amount).toStringAsFixed(2));

  double get totalGallonsCurrentYearEstimate => double.parse(_getGallonsCurrentYearEstimate().toStringAsFixed(2));

  /// The current total CO2 KG of all receipts
  double get totalCO2KG => double.parse(items
      .map((receipt) => receipt.emissions)
      .fold(0, (prev, amount) => prev + amount).toStringAsFixed(2));

  double get totalCO2KGCurrentYearEstimate => double.parse(_getC02CurrentYearEstimate().toStringAsFixed(2));

  /// Is any one calculating
  bool get anyCalculating =>
      items.where((element) => element.calculating).length > 0;

  ///https://www.epa.gov/greenvehicles/greenhouse-gas-emissions-typical-passenger-vehicle
  double get getC02Score => double.parse((totalCO2KGCurrentYearEstimate / 4600).toStringAsFixed(2));

  List<ReceiptModel> _reversedReceipts() {
    //items.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    //Iterable inReverse = items.reversed;
    //return inReverse.toList();
    return items;
  }

  /// Adds [receipt] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(XFile file) {
    _receipts.insert(0,ReceiptModel(file, notify));
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void _addReceiptModel(ReceiptModel receiptModel) {
    _receipts.insert(0,receiptModel);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  double _getPriceCurrentYearEstimate() {
    //Reversed.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    DateTime oneYearAgo = DateTime.now().subtract(Duration(days: 365));
    DateTime oldestDate = itemsReversed.last.dateTime;
    DateTime today = DateTime.now();

    List<ReceiptModel> allReceiptsCurrentYear = itemsReversed
        .where((e) => e.dateTime.compareTo(oneYearAgo) > 0)
        .where((e) => !e.calculating)
        .toList();

    double totalAmount = allReceiptsCurrentYear
        .map((receipt) => receipt.price)
        .fold(0, (prev, amount) => prev + amount);

    int timespan = today.difference(oldestDate).inDays;

    double predictedCO2 = totalAmount / (timespan / 365);

    //return the estimate
    return predictedCO2;
  }

  double _getGallonsCurrentYearEstimate() {
    //Reversed.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    DateTime oneYearAgo = DateTime.now().subtract(Duration(days: 365));
    DateTime oldestDate = itemsReversed.last.dateTime;
    DateTime today = DateTime.now();

    List<ReceiptModel> allReceiptsCurrentYear = itemsReversed
        .where((e) => e.dateTime.compareTo(oneYearAgo) > 0)
        .where((e) => !e.calculating)
        .toList();

    double totalAmount = allReceiptsCurrentYear
        .map((receipt) => receipt.gallons)
        .fold(0, (prev, amount) => prev + amount);

    int timespan = today.difference(oldestDate).inDays;
    print(timespan);
    double predictedCO2 = totalAmount / (timespan / 365);

    //return the estimate
    return predictedCO2;
  }

  double _getC02CurrentYearEstimate() {
    //itemsReversed.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    DateTime oneYearAgo = DateTime.now().subtract(Duration(days: 365));
    DateTime oldestDate = itemsReversed.last.dateTime;
    DateTime today = DateTime.now();

    List<ReceiptModel> allReceiptsCurrentYear = itemsReversed
        .where((e) => e.dateTime.compareTo(oneYearAgo) > 0)
        .where((e) => !e.calculating)
        .toList();

    double totalAmount = allReceiptsCurrentYear
        .map((receipt) => receipt.emissions)
        .fold(0, (prev, amount) => prev + amount);

    int timespan = today.difference(oldestDate).inDays;
    double predictedCO2 = totalAmount / (timespan / 365);

    //return the estimate
    return predictedCO2;
  }
}
