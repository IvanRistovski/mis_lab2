import 'package:flutter/material.dart';

class RecipeInstructions extends StatelessWidget {
  final String instructions;

  const RecipeInstructions({super.key, required this.instructions});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Instructions",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          instructions,
          style: const TextStyle(
            fontSize: 18,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
