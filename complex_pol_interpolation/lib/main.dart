import 'package:flutter/material.dart';
import './ui/condition_list.dart';
import './ui/chart_screen.dart';
import './ui/introdution.dart';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatefulWidget {

  ChartScreen chartScreen = ChartScreen();
  CardList cartoes = CardList();

  @override
  _MeuAppState createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {

  void refresh(){
    setState(() {

    });

  }

  @override
  Widget build(BuildContext context) {
    widget.chartScreen.polinomio = widget.cartoes.polinomio;
    //widget.cartoes.brother = widget.chartScreen;
    widget.cartoes.callback = refresh;
    int _index = 0;
    widget.chartScreen.xf = widget.cartoes.xf;
    widget.chartScreen.xi = widget.cartoes.xi;
    print('limitantes: ${widget.chartScreen.xi} ${widget.chartScreen.xf}');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          accentColor: Colors.deepPurpleAccent,
          cursorColor: Colors.deepPurpleAccent,
          primaryColor: Colors.deepPurple
      ),
      home: DefaultTabController(
        length: 3,
        initialIndex: _index,
        child: Scaffold(
          appBar: AppBar(
            title: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.info)),
                Tab(icon: Icon(Icons.format_list_bulleted)),
                Tab(icon: Icon(Icons.show_chart)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Introducao(),
              widget.cartoes,
              widget.chartScreen,
            ],
          ),
        ),
      ),
    );
  }
}
