import "package:flutter/material.dart";

class CounterProvider extends ChangeNotifier {
  int count = 0;

  increment() {
    count++;
    notifyListeners();
  }

  decrement() {
    count--;
    notifyListeners();
  }

  setZero() {
    count = 0;
    notifyListeners();
  }
}
