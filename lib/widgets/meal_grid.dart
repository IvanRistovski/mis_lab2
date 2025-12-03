import 'package:flutter/material.dart';
import '../models/meal_model.dart';
import 'meal_card.dart';

class MealGrid extends StatelessWidget {
  final List<Meal> meals;
  final VoidCallback onRefresh;

  const MealGrid({
    super.key,
    required this.meals,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: meals.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return MealCard(
          meal: meals[index],
          onRefresh: onRefresh,
        );
      },
    );
  }
}
