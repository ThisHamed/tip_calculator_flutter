import 'package:flutter/material.dart';

class AppStateProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  int _personCounter = 1;
  double _sliderValue = 0.0;
  double _billAmountValue = 0.0;

  // Getters
  bool get isDarkMode => _isDarkMode;
  int get personCounter => _personCounter;
  double get sliderValue => _sliderValue;
  double get billAmountValue => _billAmountValue;

  double get totalTip => _billAmountValue * _sliderValue;
  double get totalPerPerson =>
      ((_billAmountValue * _sliderValue) + _billAmountValue) / _personCounter;

  // Methods to update state
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void incrementPersonCounter() {
    _personCounter++;
    notifyListeners();
  }

  void decrementPersonCounter() {
    if (_personCounter > 1) {
      _personCounter--;
      notifyListeners();
    }
  }

  void updateSliderValue(double value) {
    _sliderValue = value;
    notifyListeners();
  }

  void updateBillAmount(String value) {
    _billAmountValue = double.tryParse(value) ?? 0.0;
    notifyListeners();
  }
}