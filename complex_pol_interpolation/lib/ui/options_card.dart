import 'package:flutter/material.dart';

class OptionsCard extends StatefulWidget {
 // Function ativa;
  bool isComplex, isDeg;
  @override
  _OptionsCardState createState() => _OptionsCardState();
  OptionsCard(this.isComplex, this.isDeg);//, this.ativa);
}

class _OptionsCardState extends State<OptionsCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
child: ListTile(
  title: Text('Opções de Entrada'),
  subtitle: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Row(
        children: <Widget>[
          Checkbox(value: widget.isComplex,
            onChanged: (bool val){
            setState(() {
              widget.isComplex = val;
             // widget.ativa(val);
            });
            },),
          Text('Coeficientes Complexos')
        ],
      ),
      Row(
        children: <Widget>[
          Checkbox(value: widget.isDeg,
          onChanged: (widget.isComplex) ? (bool val){
            setState(() {
              widget.isDeg = val;
            });
          } : null,),
          Text('Usar Graus')
        ],
      ),
    ],
  ),
),


    );

  }

}
