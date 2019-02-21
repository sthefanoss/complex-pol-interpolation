import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../math/complex.dart';
import './condition_card.dart';
import '../math/interpolation.dart';


List<ConditionCard> _list = [
  ConditionCard(false, false),
];

class CardList extends StatefulWidget {
  static const int MAX = ConditionCard.MAXORDER + 1;
  List<Complex> polinomio;
  bool isNaN = false;
  String message;
  Function callback;
  double xf, xi;

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  Widget _criarCarta(ConditionCard user, [int index]) {
    var newCard = _list[index];
    newCard.delete = index != null ? () => _deletarCarta(index) : null;
    newCard.callBack = index != null ? () => _verificar() : null;
    return ListTile(
        key: ValueKey<ConditionCard>(user),
        title: newCard);
  }

  void _adicionarCarta() {
    if (_list.length < CardList.MAX)
      setState(() {
        int index = _list.length;
        _list.add(ConditionCard(false, false));
        _listKey.currentState
            .insertItem(index, duration: Duration(milliseconds: 500));
      });
  }

  void _deletarCarta(int index) {
    setState(() {
      var user = _list.removeAt(index);
      _listKey.currentState.removeItem(
        index,
        (BuildContext context, Animation<double> animation) {
          return FadeTransition(
            opacity:
                CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0)),
            child: SizeTransition(
              sizeFactor:
                  CurvedAnimation(parent: animation, curve: Interval(0.0, 1.0)),
              axisAlignment: 0.0,
              child: user,
            ),
          );
        },
        duration: Duration(milliseconds: 600),
      );
    });
  }

  void _verificar() {
    setState(() {
      try {
        //Cria uma lista para os elementos verificados
        List<ConditionCard> verificados = new List<ConditionCard>();
        for (int i = 0; i < _list.length; i++) {
          if (_list[i].isDone) verificados.add(_list[i]);
        }
        //Se a lista estiver vazia
        if (verificados.length == 0) {
          widget.message = 'Confirme pontos.';
          widget.polinomio = null;
        }
        //Se não...
        else {
          widget.polinomio = _darValor(verificados);
          if (!widget.isNaN) {
            widget.message =
            'p(x) = ${InterpolationEntry.polToString(widget.polinomio)}';
            widget.xf = double.negativeInfinity;
            widget.xi = double.infinity;
            for(int i=0;i<verificados.length;i++){
            if(verificados[i].xValue > widget.xf)
              widget.xf = verificados[i].xValue;
            if(verificados[i].xValue < widget.xi)
              widget.xi = verificados[i].xValue;
            }
            if(widget.xf == widget.xi){
              widget.xf += 1;
              widget.xi -= 1;
            }
          }
          else
            widget.message = 'Solução divergente!';
        }
      } catch (e) {
        //Mostra mensagem de erro
        widget.message = e;
        return;
      }
    });
    widget.callback();
  }

  List<Complex> _darValor(List<ConditionCard> cardList) {
    var entry = List<InterpolationEntry>(cardList.length);
    for (int i = 0; i < cardList.length; i++) {
      entry[i] = InterpolationEntry(
          cardList[i].xValue, cardList[i].yValue, cardList[i].dValue);
    }
    var pol = InterpolationEntry.interpolate(entry);
    if (pol[0].real.isNaN ||
        pol[0].real.isInfinite ||
        pol[0].imaginary.isNaN ||
        pol[0].imaginary.isInfinite) {
      widget.isNaN = true;
      return null;
    } else {
      widget.isNaN = false;
      return pol;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(children: [
          Row(
            children: <Widget>[
              Flexible(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        title: Text('Pontos e Condições Iniciais'),
                        subtitle: Text(
                            'Entre os dados iniciais e confirme cada um, então clique em calcular.'),
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Text('${_list.length}/${CardList.MAX}'),
                          radius: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed:
                    (_list.length < CardList.MAX) ? _adicionarCarta : null,
              )
            ],
          ),
          Divider(),
          Flexible(
            child: Container(
              color: Colors.grey[200],
              child: AnimatedList(
                key: _listKey, //Added the key
                initialItemCount: _list.length,
                itemBuilder:
                    (BuildContext context, int index, Animation animation) {
                  return _criarCarta(_list[index], index);
                },
              ),
            ),
          ),
          Divider(),
Padding(
  padding: EdgeInsets.all(4),
  child: (widget.isNaN)
      ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('${widget.message}'),
        IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Solução Divergente'),
                      content: Text(
                          'Verifique se sua matemática faz sentido! \nI - Não coloque duas entradas com o mesmo tempo e a mesma ordem;\nII - O número da ordem de derivação não pode ser igual ou maior do que o número de entradas.'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Ok'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  });
            })
      ])
      : Text((widget.message != null)
      ? '${widget.message}'
      : 'Aguardando entradas.', style: TextStyle(fontSize: 17),),

)

        ]),
      ),
    );
  }
}
