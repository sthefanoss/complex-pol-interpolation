import 'package:flutter/material.dart';


TextStyle _temaComum(){
  return TextStyle(fontSize: 20);
}

TextStyle _temaMath(){
  return TextStyle(fontStyle: FontStyle.italic,fontSize: 15);
}

class Introducao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Interpolação Polinomial',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8,bottom: 16),
              child: Text(
                  '    A geração de trajetória é um passo importante na hora de criar o caminho que ligará dois pontos no espaço, podendo ser a posição inicial e a final, por exemplo. Uma das formas de criar uma função para ligar dois pontos é um polinômio interpolador. Esse tem a seguinte forma:',
              style: _temaComum(),textAlign: TextAlign.justify,),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(' p(x) = a₀ + a₁x + a₂x² + a₃x³ + ... + aₙxⁿ',
                style: _temaMath(),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('   Genericamente o polinômio pode ter qualquer grau, mas, por questões computacionais, geralmente os termos são reduzidos.',
              style: _temaComum(),textAlign: TextAlign.justify),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Pontos e Condições Iniciais',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('   Nosso objetivo é encontrar os valores de cada coeficiente do polinômio para, então, entender o comportamento da função. Uma reta precisa de pelo menos dois pontos; uma parábola, três, mas pode ocorrer o caso onde todos estarem alinhados, resultando em uma reta. Então, como primeira observação, o número de pontos usados para gerar um polinômio não garante o seu grau, mas, necessariamente, precisamos de n pontos para termos um polinômio de grau n-1.',
              style: _temaComum(),textAlign: TextAlign.justify),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('   Além de pontos como entradas, podemos ter, também, derivadas de ordem que não ultrapasse, nem seja igual ao grau do polinômio - até porque derivar a função até o seu grau resultaria em zero.',
              style: _temaComum(),textAlign: TextAlign.justify),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Exemplo 1',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Utilizando as seguintes entradas: ',
              style: _temaComum(),),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8,bottom: 8),
                child: Text('y(x₀) = y₀    y(x₁) = y₁    y(x₂) = y₂',
                style: _temaMath(),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Podemos esperar: ',
                style: _temaComum(),),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8,bottom: 8),
                child: Text('p(x) = a₀ + a₁x + a₂x²',
                  style: _temaMath(),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('A resolução será um sistema linear com a mesma ordem do polinômio:',
                style: _temaComum(),),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8,bottom: 8),
                child: Text('a₀ + a₁x₀ + a₂x₀² = y₀',
                  style: _temaMath(),),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8,bottom: 8),
                child: Text('a₀ + a₁x₁ + a₂x₁² = y₁',
                  style: _temaMath(),),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8,bottom: 8),
                child: Text('a₀ + a₁x₂ + a₂x₂² = y₂',
                  style: _temaMath(),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Passando para a forma matricial:',
                style: _temaComum(),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('|1    x₀    x₀²|',style: _temaMath(),),
                      Text('|1    x₁    x₁²|',style: _temaMath()),
                      Text('|1    x₂    x₂²|',style: _temaMath())
                    ],
                  ),
                  Text(' * ',style: _temaMath()),
                  Column(
                    children: <Widget>[
                      Text('|  a₀  |',style: _temaMath()),
                      Text('|  a₁  |',style: _temaMath()),
                      Text('|  a₂  |',style: _temaMath())
                    ],
                  ),
                  Text(' = ',style: _temaMath()),
                  Column(
                    children: <Widget>[
                      Text('|  y₀  |',style: _temaMath()),
                      Text('|  y₁  |',style: _temaMath()),
                      Text('|  y₂  |',style: _temaMath())
                    ],
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('   Basta aplicar métodos matriciais para resolver o sistema, como fatoração LU, por exemplo.',
              style: _temaComum(),textAlign: TextAlign.justify,),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Exemplo 2',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('   Caso alguma entrada seja a derivada da função y(x), alguns zeros começarão a aparecer na matriz de tempos. Imagine que a terceira condição para o caso anterior é:',
                style: _temaComum(),textAlign: TextAlign.justify,),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8,bottom: 8),
                child: Text('y\'(x₂) = y₂',
                  style: _temaMath(),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('   Isso resulta em uma derivada na linha correspondente na matriz dos tempos:',
                style: _temaComum(),textAlign: TextAlign.justify,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('|1    x₀    x₀²|',style: _temaMath(),),
                      Text('|1    x₁    x₁²|',style: _temaMath()),
                      Text('|0    1    2x₂|',style: _temaMath())
                    ],
                  ),
                  Text(' * ',style: _temaMath()),
                  Column(
                    children: <Widget>[
                      Text('|  a₀  |',style: _temaMath()),
                      Text('|  a₁  |',style: _temaMath()),
                      Text('|  a₂  |',style: _temaMath())
                    ],
                  ),
                  Text(' = ',style: _temaMath()),
                  Column(
                    children: <Widget>[
                      Text('|  y₀  |',style: _temaMath()),
                      Text('|  y₁  |',style: _temaMath()),
                      Text('|  y₂  |',style: _temaMath())
                    ],
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('   Mas, contanto que a matriz continue sendo inversível, é garantida a solução para o sistema.',
                style: _temaComum(),textAlign: TextAlign.justify,),
            ),
          ],
        ),
      ),
    );
  }
}
