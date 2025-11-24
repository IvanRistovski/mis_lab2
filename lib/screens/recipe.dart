import 'package:flutter/material.dart';
import 'package:mis_lab2/widgets/recipe_image.dart';
import 'package:mis_lab2/widgets/recipe_ingredients.dart';
import 'package:mis_lab2/widgets/recipe_instructions.dart';
import 'package:mis_lab2/widgets/recipe_title.dart';
import 'package:mis_lab2/widgets/recipe_youtube.dart';
import '../models/recipe_model.dart';
import '../models/recipe_model.dart';
import '../services/api_service.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  final ApiService _api = ApiService();
  late String mealId;

  Recipe? _recipe;
  bool _loading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mealId = ModalRoute.of(context)!.settings.arguments as String;
    _loadDetails();
  }

  void _loadDetails() async {
    final result = await _api.loadRecipe(mealId);
    setState(() {
      _recipe = result;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_recipe?.name ?? ""),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: RecipeImage(imageUrl: _recipe!.img)
            ),
            const SizedBox(height: 20),
            RecipeTitle(title: _recipe!.name),

            const SizedBox(height: 20),
            RecipeInstructions(instructions: _recipe!.instructions),

            const SizedBox(height: 20),
            RecipeIngredients(ingredients: _recipe!.ingredients),

            const SizedBox(height: 20),
            RecipeYoutube(youtubeUrl: _recipe!.ytlink)
          ],
        ),
      ),
    );
  }
}
