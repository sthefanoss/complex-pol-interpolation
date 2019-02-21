import 'complex.dart';
import 'matrix.dart';
import 'dart:math';

class InterpolationEntry {
  final double x;
  final Complex y;
  final int d;
  static const List<String> _potencias = [
    '',
    '',
    '²',
    '³',
    '⁴',
    '⁵',
    '⁶',
    '⁷',
    '⁸',
    '⁹',
    '⁰'
  ];

  InterpolationEntry(this.x, this.y, this.d);

  bool test(List<Complex> func) {
    Complex sum = new Complex.rectangular(0, 0);
    for (int i = 0; i < func.length; i++) sum += func[i] * _derivada(x, i, d);

    print('$sum');
    return sum == y;
  }

  static int _expDrop(int exp, int d) {
    int prod = 1;
    for (; d > 0; d--, exp--) prod *= exp;
    return prod;
  }

  static Complex _derivada(double x, int exp, int d) {
    return (exp < d)
        ? new Complex.rectangular(0)
        : new Complex.rectangular(_expDrop(exp, d) * pow(x, exp - d));
  }

  static void _ordenate(List<InterpolationEntry> list) {
    list.sort((a, b) => (a.d.compareTo(b.d)));
  }

  static List<Complex> interpolate(List<InterpolationEntry> entry) {
    _ordenate(entry);

    var vy = new List<Complex>(entry.length);
    var matrix = new ComplexMatrix(entry.length, entry.length);

    for (int i = 0; i < entry.length; i++) {
      vy[i] = entry[i].y;
      for (int j = 0; j < entry.length; j++)
        matrix[i][j] = _derivada(entry[i].x, j, entry[i].d);
    }

    return matrix.fatoracaoLU(vy);
  }

  static List<ComplexPoint> linePlot(
      double tini, double tfinal, int steps, List<Complex> coefficents) {
    double dt = (tfinal - tini) / (steps - 1), t;
    Complex sum;
    List<ComplexPoint> data = List<ComplexPoint>(steps);
    for (int n = 0; n < steps; n++) {
      sum = Complex.rectangular(0);
      t = tini + n * dt;
      for (int p = 0; p < coefficents.length; p++)
        sum += coefficents[p] * Complex.rectangular(pow(t, p));
      data[n] = ComplexPoint(t, sum.real, sum.imaginary, sum.radius, sum.angle);
    }
    return data;
  }

  static String polToString(List<Complex> pol) {
    String buff = '';
    for (int i = 0; i < pol.length; i++)
      if (pol[i].toString() != '0') if (i == 0)
        buff += '(${pol[i]})';
      else
        buff += ' +(${pol[i]})x${_potencias[i]}';

    if (buff == '')
      return '0';
    else
      return buff;
  }
}

class ComplexPoint {
  final double time, real, imaginary, radius, angle;

  ComplexPoint(this.time, this.real, this.imaginary, this.radius, this.angle);
}
