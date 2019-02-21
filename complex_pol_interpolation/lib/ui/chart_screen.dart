import 'package:flutter/material.dart';
import '../math/complex.dart';
import '../math/interpolation.dart';
import '../ui/chart_widget.dart' as chartw;
import 'dart:math';

class ChartScreen extends StatefulWidget {
  double xi,xf;
  List<Complex> polinomio;
  @override
  ChartScreen();

  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  List<chartw.Dot> real, imaginary, radius, phase;

  @override
  Widget build(BuildContext context) {
    if (widget.polinomio != null) {
      List<ComplexPoint> data =
          InterpolationEntry.linePlot(widget.xi, widget.xf, 50, widget.polinomio);
      real = List<chartw.Dot>(data.length);
      imaginary = List<chartw.Dot>(data.length);
      radius = List<chartw.Dot>(data.length);
      phase = List<chartw.Dot>(data.length);
      for (int i = 0; i < data.length; i++) {
        real[i] = chartw.Dot(data[i].time, data[i].real);
        imaginary[i] = chartw.Dot(data[i].time, data[i].imaginary);
        radius[i] = chartw.Dot(data[i].time, data[i].radius);
        phase[i] = chartw.Dot(data[i].time, data[i].angle * 180 / pi);
      }
    } else {
      real = null;
      imaginary = null;
      radius = null;
      phase = null;
    }
    print('lista do chart :${widget.polinomio}');
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('Gráficos do Polinômio'),
                    subtitle: Text(
                        'Com o resultado da tela anterior, vizualise os gráficos do polinômio.'),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          (widget.polinomio != null)
              ? Flexible(
                  child: Container(
                    color: Colors.grey[200],
                    child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    children: <Widget>[
                      chartw.LineChart(
                        chartw.LineChart.dataPointSerie(real),
                        text: 'Re{p(x)}',autox: false,xf: widget.xf,xi: widget.xi,
                      ),
                      chartw.LineChart(chartw.LineChart.dataPointSerie(imaginary),
                          text: 'Im{p(x)}',autox: false,xf: widget.xf,xi: widget.xi),
                      chartw.LineChart(
                        chartw.LineChart.dataPointSerie(radius),
                        text: '|p(x)|',autox: false,xf: widget.xf,xi: widget.xi
                      ),
                      chartw.LineChart(chartw.LineChart.dataPointSerie(phase),
                          text: '∠p(x)',autox: false,xf: widget.xf,xi: widget.xi),
                    ],
                ),
                  ))
              : Container(),
        ]),
      ),
    );
  }
}

/////////////////////////////////////////////////////
