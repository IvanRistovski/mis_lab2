import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/api_service.dart';

class RandomRecipeNavigator {
  static final ApiService _apiService = ApiService();

  static Future<void> openRandomRecipe(BuildContext context) async {
    final recipe = await _apiService.loadRandomRecipe();
    if (recipe == null) return;

    Navigator.pushNamed(
      context,
      "/recipe",
      arguments: recipe.id.toString(),
    );
  }
}
