/// Example of a simple line chart.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class Dot {
  final double x, y;
  Dot(this.x, this.y);
}

class LineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate, autox, autoy;
  final String text;
  final double yi, yf, xi, xf;

  LineChart(this.seriesList,
      {this.autox = true,
      this.autoy = true,
      this.animate,
      this.text = '',
      this.yi,
      this.yf,
      this.xi,
      this.xf});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
        child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Stack(children: <Widget>[
                new charts.LineChart(seriesList,
                    animate: animate,
                    domainAxis: (autox)
                        ? charts.NumericAxisSpec(
                      showAxisLine: true,
                    )
                        : charts.NumericAxisSpec(
                        showAxisLine: true,
                        viewport: charts.NumericExtents(xi, xf)),
                    primaryMeasureAxis: (autoy)
                        ? charts.NumericAxisSpec(
                            showAxisLine: true,
                          )
                        : charts.NumericAxisSpec(
                            showAxisLine: true,
                            viewport: charts.NumericExtents(yi, yf))),
                Center(
                  heightFactor: 1,
                  child: Text(
                    '$text',
                    style: TextStyle(fontSize: 25),
                  ),
                )
              ]),
            )),
    );
  }


void show(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          content: this
        );

      }
    );
}

  static List<charts.Series<Dot, double>> dataPointSerie(List<Dot> data) {
    return [
      new charts.Series<Dot, double>(
        id: 'Plot',
        colorFn: (_, __) => charts.MaterialPalette.indigo.shadeDefault,
        domainFn: (Dot dt, _) => dt.x,
        measureFn: (Dot dt, _) => dt.y,
        // insideLabelStyleAccessorFn: ,
        data: data,
        //  measureUpperBoundFn: (ComplexPoint cp, _) => 1,
        //measureLowerBoundFn: (ComplexPoint cp, _) => -1,
      ),
    ];
  }
}
