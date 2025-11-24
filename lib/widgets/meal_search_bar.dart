import 'package:flutter/material.dart';

class MealsSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final String category;

  const MealsSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Search meals in $category",
          prefixIcon: const Icon(Icons.search),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
