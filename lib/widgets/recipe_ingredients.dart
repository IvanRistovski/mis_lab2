import 'package:flutter/material.dart';

class RecipeIngredients extends StatelessWidget {
  final Map<String, String> ingredients;

  const RecipeIngredients({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Ingredients",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),

        ...ingredients.entries.map(
              (e) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              "${e.key} - ${e.value}",
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
