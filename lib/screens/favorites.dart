import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/meal_model.dart';
import '../widgets/meal_grid.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  List<Meal> _getFavorites() {
    return ApiService.cachedMealsByCategory.values
        .expand((list) => list)
        .where((meal) => meal.isFavourite)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final favs = _getFavorites();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Meals"),
      ),
      body: favs.isEmpty
          ? const Center(child: Text("No favorite meals yet"))
          : MealGrid(
        meals: favs,
        onRefresh: () => (context as Element).markNeedsBuild(),
      ),
    );
  }
}
