import 'package:flutter/material.dart';
import '../models/food_model.dart';

class FoodProvider extends ChangeNotifier {
  final List<FoodModel> _foodList = [];

  final double dailyGoal = 2000;

  List<FoodModel> get foodList => _foodList;

  double get totalCalories {
    return _foodList.fold(
      0,
          (total, food) => total + food.calories,
    );
  }

  double get remainingCalories {
    return dailyGoal - totalCalories;
  }

  void addFood(String name, double calories) {
    _foodList.add(
      FoodModel(
        name: name,
        calories: calories,
      ),
    );

    notifyListeners();
  }

  void deleteFood(int index) {
    _foodList.removeAt(index);
    notifyListeners();
  }
}