import 'package:flutter/material.dart';
import '../math/complex.dart';

TextStyle get _numericStyle => TextStyle(fontSize: 20);

class ConditionCard extends StatefulWidget {
  static const int MAXORDER = 9;
  final TextEditingController _timeController = TextEditingController(),
      _p1Controller = TextEditingController(),
      _p2Controller = TextEditingController(),
      _difController = TextEditingController(text: '0');
  static bool _isDeg = true;
  bool isPol = false;
  bool _isDone = false;
  Complex _yValue;
  int _dValue;
  double _xValue;
  Function delete, callBack;

  bool get isDone => _isDone;
  Complex get yValue => _yValue;
  double get xValue => _xValue;
  int get dValue => _dValue;

  ConditionCard(this.isPol, this._isDone);

  @override
  _ConditionCardState createState() => _ConditionCardState();

  bool deleteAtList(List<ConditionCard> list) {
    if (list.contains(this)) {
      list.remove(this);
      return true;
    }
    return false;
  }

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is ConditionCard &&
          this.isPol == other.isPol &&
          this._isDone == other._isDone &&
          this._yValue == other._yValue &&
          this._dValue == other._dValue &&
          this._xValue == other._xValue;

  @override
  int get hashCode =>
      isPol.hashCode ^
      _isDone.hashCode ^
      _yValue.hashCode ^
      _dValue.hashCode ^
      _xValue.hashCode;
}

class _ConditionCardState extends State<ConditionCard> {
  bool _complexRead() {
    if (widget._p1Controller.text.isNotEmpty ||
        widget._p2Controller.text.isNotEmpty) {
      try {
        double p1 = (widget._p1Controller.text.isNotEmpty)
                ? double.parse(widget._p1Controller.text)
                : 0,
            p2 = (widget._p2Controller.text.isNotEmpty)
                ? double.parse(widget._p2Controller.text)
                : 0;

        if (widget.isPol && p1 < 0) {
          widget._yValue = null;
          return false;
        }

        widget._yValue = (widget.isPol)
            ? Complex.polar(p1, p2, ConditionCard._isDeg)
            : Complex.rectangular(p1, p2);

        return true;
      } catch (Exception) {
        print('$Exception');
        widget._yValue = null;
        return false;
      }
    }
  }

  void _writeComplex() {
    print('${widget._yValue}');
    if (widget.isPol) {
      widget._p1Controller.text = '${widget._yValue.radius}';
      widget._p2Controller.text = (ConditionCard._isDeg)
          ? '${widget._yValue.angleDeg}'
          : '${widget._yValue.angle}';
    } else {
      widget._p1Controller.text = '${widget._yValue.real}';
      widget._p2Controller.text = '${widget._yValue.imaginary}';
    }
  }

  void _delete(){
    widget.delete();
    widget.callBack();
  }

  void _changeForm() {
    setState(() {
      try {
        _complexRead();
      } catch (e) {}
      widget.isPol = !widget.isPol;
      try {
        _writeComplex();
      } catch (e) {}
    });
  }

  bool _confirm() {
    try {
      if (_complexRead()) {
        _writeComplex();
        double t;
        int d;
        t = double.parse(widget._timeController.text);
        d = int.parse(widget._difController.text);
        if (d < 0) d *= -1;
        setState(() {
          widget._dValue = d;
          widget._xValue = t;
          widget._timeController.text = '$t';
          widget._difController.text = '$d';
          widget._isDone = true;
        });
        widget.callBack();
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: (widget._isDone) ? 2 : 5,
      child: Column(children: <Widget>[
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: (widget._isDone)
                  ? null
                  : () {
                      widget._timeController.text = '';
                      widget._difController.text = '';
                      widget._p1Controller.text = '';
                      widget._p2Controller.text = '';
                      widget._yValue = null;
                    },
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  enabled: !widget._isDone,
                  keyboardType: TextInputType.numberWithOptions(
                    signed: true,
                    decimal: true,
                  ),
                  controller: widget._timeController,
                  decoration: InputDecoration(
                      labelText: 'Valor de x',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  enabled: !widget._isDone,
                  controller: widget._difController,
                  keyboardType: TextInputType.numberWithOptions(
                    signed: false,
                    decimal: false,
                  ),
                  decoration: InputDecoration(
                      labelText: 'Derivação',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
              ),
            ),
            IconButton(
              icon: (widget._isDone) ? Icon(Icons.edit) : Icon(Icons.done),
              onPressed: (widget._isDone)
                  ? () {
                      setState(() {
                        widget._isDone = !widget._isDone;
                        widget.callBack();
                      });
                    }
                  : _confirm,
            )
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: (widget.isDone) ? null : _delete,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  enabled: !widget._isDone,
                  keyboardType: TextInputType.numberWithOptions(
                    signed: true,
                    decimal: true,
                  ),
                  controller: widget._p1Controller,
                  decoration: InputDecoration(
                      labelText: (widget.isPol) ? 'Módulo de y' : 'Parte real de y',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  enabled: !widget._isDone,
                  keyboardType: TextInputType.numberWithOptions(
                    signed: true,
                    decimal: true,
                  ),
                  controller: widget._p2Controller,
                  decoration: InputDecoration(
                      labelText: (widget.isPol) ? 'Fase de y' : 'Parte imag. de y',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
              ),
            ),
            IconButton(
              icon: Text(
                (widget.isPol) ? '∠' : 'i',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight:
                      (widget._isDone) ? FontWeight.normal : FontWeight.bold,
                ),
              ),
              onPressed: (widget._isDone) ? null : _changeForm,
            ),
          ],
        )
      ]),
    );
  }
}
