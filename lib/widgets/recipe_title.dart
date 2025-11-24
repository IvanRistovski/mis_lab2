import 'package:flutter/material.dart';

class RecipeTitle extends StatelessWidget {
  final String title;

  const RecipeTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
