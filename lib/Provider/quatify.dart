import 'package:flutter/material.dart';

class QuatifyProvider extends ChangeNotifier {
  int _currentNumber = 1;
  List<double> _baseIngredientAmounts = [];
  int get currentNumber => _currentNumber;
  //Set initial ingredients amounts
  void setBaseIngredientAmounts(List<double> amounts) {
    _baseIngredientAmounts = amounts;
    notifyListeners();
  }

  // Update ingredient amounts based on the quantify
  List<String> get updateIngredientAmounts {
    return _baseIngredientAmounts
        .map<String>((amount) => (amount * _currentNumber).toStringAsFixed(1))
        .toList();
  }

  // Increase servings
  void increaseQuantify() {
    _currentNumber++;
    notifyListeners();
  }

  // decrease servings
  void decreaseQuantify() {
    if (_currentNumber > 1) {
      _currentNumber--;
      notifyListeners();
    }
  }
}
