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
                      Card(
                        elevation: 8.0,
                        margin: new EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(64, 75, 96, .9),
                          ),
                          child: ListTile(
                            title: Gauge(
                              receipts: receipts,
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(
                                left: 15.0,
                                bottom: 10.0,
                              ),
                              child: Text(
                                "My estimated CO2e emissions for this year in comparison to an average US citizen.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      _getStatistic(
                        "This years estimates",
                        receipts.totalCO2KGCurrentYearEstimate,
                        receipts.totalGallonsCurrentYearEstimate,
                        receipts.totalPriceCurrentYearEstimate,
                      ),
                      _getStatistic(
                        "Lifetime",
                        receipts.totalCO2KG,
                        receipts.totalGallons,
                        receipts.totalPrice,
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }

  Widget _getStatistic(
      String title, double emissions, double fuel, double total) {
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
          title: Text(
            "Lifetime",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              top: 10.0,
            ),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Icon(Icons.filter_drama, color: Colors.red.shade400),
                    Text(
                      " ${emissions.toString()} kg CO2e",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.local_gas_station, color: Colors.white),
                    Text(
                      " ${fuel.toString()} gallons",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.payments, color: Colors.white),
                    Text(
                      " \$ ${total.toString()}",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
