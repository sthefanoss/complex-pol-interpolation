import 'dart:math';
import 'package:quiver/core.dart';

class Complex {
  static int PRECISION = 3;
  double _real, _imaginary;
  static final Complex I = Complex.rectangular(0, 1);
  static const double EPSILON = 0.000000001;

  //construtores
  Complex.rectangular(double real, [double imaginary = 0]) {
    _real = real;
    _imaginary = imaginary;
  }

  Complex.polar(double radius, double angle, [bool isDeg = false]) {
    _real = isDeg ? radius * cos(angle * pi / 180) : radius * cos(angle);
    _imaginary = isDeg ? radius * sin(angle * pi / 180) : radius * sin(angle);
  }

  //gets
  double get real => _real;
  double get imaginary => _imaginary;
  double get radius => sqrt(_real * _real + _imaginary * _imaginary);
  double get angle => atan2(_imaginary, _real);
  double get angleDeg => atan2(_imaginary, _real) * 180 / pi;

  static Complex cPow(Complex c, int p) {
    return Complex.polar(pow(c.radius, p), c.angle * p);
  }

  @override
  int get hashCode => hash2(_real.hashCode, _imaginary.hashCode);

  String _signal() {
    if (_imaginary > 0)
      return '+';
    else
      return '-';
  }

  String toString() {
    //Caso 0 + 0i
    if (radius < EPSILON)
      return '0';
    //caso bi
    else if (abs(_real) < EPSILON)
      return _imaginary < 0
          ? '-i${abs(_imaginary).toStringAsPrecision(PRECISION)}'
          : 'i${_imaginary.toStringAsPrecision(PRECISION)}';
    else if (abs(_imaginary) < EPSILON)
      return '${real.toStringAsPrecision(PRECISION)}';
    else
      return '${real.toStringAsPrecision(PRECISION)} ${_signal()}i${abs(_imaginary).toStringAsPrecision(PRECISION)}';
  }

  //overload
  Complex operator +(other) {
    return Complex.rectangular(
        _real + other.real, _imaginary + other.imaginary);
  }

  Complex operator -(Complex other) {
    return Complex.rectangular(
        _real - other._real, _imaginary - other._imaginary);
  }

  Complex operator *(Complex other) {
    return Complex.rectangular(
        _real * other._real - _imaginary * other._imaginary,
        _real * other._imaginary + _imaginary * other._real);
  }

  Complex operator /(Complex other) {
    double div =
        other._real * other._real + other._imaginary * other._imaginary;
    return Complex.rectangular(
        (_real * other._real + _imaginary * other._imaginary) / div,
        (_imaginary * other._real - _real * other._imaginary) / div);
  }

  static num abs(num n) {
    return n > 0 ? n : -n;
  }

  bool operator ==(other) {
    return this._real == other._real && this._imaginary == other._imaginary ||
        (abs(this._real - other._real) < EPSILON) &&
            (abs(this._imaginary - other._imaginary) < EPSILON);
  }
}
