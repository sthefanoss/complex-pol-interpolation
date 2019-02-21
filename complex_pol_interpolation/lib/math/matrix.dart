import 'complex.dart';

class ComplexMatrix {
  List<List<Complex>> _m;

  List<Complex> operator [](int i) {
    return _m[i];
  }

  ComplexMatrix(int m, int n) {
    _m = new List<List<Complex>>(m);
    for (int i = 0; i < m; i++) _m[i] = new List<Complex>(n);
  }

  void setZeros() {
    for (int i = 0; i < _m.length; i++)
      for (int j = 0; j < _m[0].length; j++)
        _m[i][j] = Complex.rectangular(0, 0);
  }

  List<Complex> fatoracaoLU(List<Complex> rightPart) {
    {
      // decomposition of matrix
      var lu = new ComplexMatrix(_m.length, _m.length);
      lu.setZeros();

      Complex sum;

      for (int i = 0; i < _m.length; i++) {
        for (int j = i; j < _m.length; j++) {
          sum = Complex.rectangular(0, 0);
          for (int k = 0; k < i; k++) sum += lu[i][k] * lu[k][j];
          lu._m[i][j] = _m[i][j] - sum;
        }
        for (int j = i + 1; j < _m.length; j++) {
          sum = Complex.rectangular(0, 0);
          for (int k = 0; k < i; k++) sum += lu[j][k] * lu[k][i];
          lu[j][i] =
              ((new Complex.rectangular(1) / lu[i][i]) * (_m[j][i] - sum));
        }
      }

      // find solution of Ly = b
      var y = new List<Complex>(_m.length);
      for (int i = 0; i < _m.length; i++) {
        sum = Complex.rectangular(0, 0);
        for (int k = 0; k < i; k++) sum += lu[i][k] * y[k];
        y[i] = rightPart[i] - sum;
      }
      // find solution of Ux = y
      var x = new List<Complex>(_m.length);
      for (int i = _m.length - 1; i >= 0; i--) {
        sum = Complex.rectangular(0, 0);
        for (int k = i + 1; k < _m.length; k++) sum += lu[i][k] * x[k];
        x[i] = ((new Complex.rectangular(1) / lu[i][i]) * (y[i] - sum));
      }
      return x;
    }
  }
}
