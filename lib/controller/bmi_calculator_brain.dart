import 'dart:math';

class BmiCalculatorBrain {
  final int height;
  final int weight;
  final int age;
  BmiCalculatorBrain({
    required this.height,
    required this.weight,
    required this.age,
  }) {
    _bmi = weight / pow(height / 100, 2);
  }

  late double _bmi;
  String calculateBMI() {
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi >= 30) {
      return 'Obese';
    } else if (_bmi >= 18.5) {
      return 'Normal Weight';
    } else {
      return 'UnderWeight';
    }
  }

  String getInterpretation() {
    if (_bmi >= 25) {
      return 'You have a higher than normal body weight. Try to exercise more.';
    } else if (_bmi >= 18.5) {
      if (age < 18) {
        return 'You have a normal weight. Make sure to eat enough for healthy growth!';
      }
      return 'You have a normal body weight. Good job!';
    } else {
      if (age > 65) {
        return 'Your weight is low. It is important to maintain strength at your age.';
      } else {
        return 'You have a lower than normal body weight. You can eat a bit more.';
      }
    }
  }
}
