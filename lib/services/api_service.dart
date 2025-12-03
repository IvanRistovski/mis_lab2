import 'dart:convert';
import '../models/category_model.dart';
import 'package:http/http.dart' as http;

import '../models/meal_model.dart';
import '../models/recipe_model.dart';


class ApiService {
  final baseUrl = "https://www.themealdb.com/api/json/v1/1";

  static Map<String, List<Meal>> cachedMealsByCategory = {};

  Future<List<Category>> loadCategories() async {
    final response = await http.get(
      Uri.parse("$baseUrl/categories.php"),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List list = jsonData["categories"];
      return list.map((c) => Category.fromJson(c)).toList();
    }

    return [];
  }

  Future<Category?> searchCategoryByName(String name) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/categories.php'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<dynamic> list = data['categories'];
        List<Category> categories =
        list.map((item) => Category.fromJson(item)).toList();

        return categories.firstWhere(
              (c) => c.name.toLowerCase() == name.toLowerCase(),
          orElse: () => throw Exception("Category not found"),
        );
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<Meal>> loadMealsByCategory(String category) async {
    if (cachedMealsByCategory.containsKey(category)) {
      return cachedMealsByCategory[category]!;
    }

    final url = Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=$category');
    final response = await http.get(url);

    final data = json.decode(response.body);
    final meals = (data["meals"] as List)
        .map((m) => Meal.fromJson(m))
        .toList();

    cachedMealsByCategory[category] = meals;
    return meals;
  }


  Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(
      Uri.parse("$baseUrl/search.php?s=$query"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data["meals"] == null) return [];

      final List list = data["meals"];
      return list.map((m) => Meal.fromJson(m)).toList();
    }

    return [];
  }

  Future<Recipe?> loadRecipe(String id) async {
    final response = await http.get(
      Uri.parse("$baseUrl/lookup.php?i=$id"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final list = data["meals"];
      if (list == null) return null;
      return Recipe.fromJson(list[0]);
    }

    return null;
  }

  Future<Recipe?> loadRandomRecipe() async {
    final response = await http.get(
      Uri.parse("$baseUrl/random.php"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final list = data["meals"];
      if (list == null || list.isEmpty) return null;
      return Recipe.fromJson(list[0]);
    }

    return null;
  }
}
