import 'package:flutter/material.dart';
import 'package:my_app/models/receipts.dart';
import 'package:my_app/views/insigths/gauge.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Insights extends StatelessWidget {
  bool isCardView = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<ReceiptsModel>(
      builder: (context, receipts, child) {
        return receipts.length == 0
            ? Text("No Data yet")
            : Center(
                child: Container(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'My C02e emissions',
                          style: new TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'My estimated CO2e emissions for this year in comparison to an average US citizen.',
                          style: new TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Gauge(
                        receipts: receipts,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'This years estimates',
                          style: new TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          border: TableBorder.all(
                              color: Colors.blueGrey,
                              style: BorderStyle.solid,
                              width: 1),
                          children: [
                            _getTableRow("CO2e emissions",
                                receipts.totalCO2KGCurrentYearEstimate.toString() + " kg"),
                            _getTableRow("Fuel",
                                receipts.totalGallonsCurrentYearEstimate.toString() + " gallons"),
                            _getTableRow("Price",
                                "\$ " + receipts.totalPriceCurrentYearEstimate.toString()),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Lifetime',
                          style: new TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Table(

                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          border: TableBorder.all(
                              color: Colors.blueGrey,
                              style: BorderStyle.solid,
                              width: 1),
                          children: [
                            _getTableRow("CO2e emissions",
                                receipts.totalCO2KG.toString() + " kg"),
                            _getTableRow("Fuel",
                                receipts.totalGallons.toString() + " gallons"),
                            _getTableRow("Price",
                                "\$ " + receipts.totalPrice.toString()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }

  _getTableRow(String title, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: new TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            style: new TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
