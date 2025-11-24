import 'package:flutter/material.dart';

class CategorySearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const CategorySearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: "Search categories",
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
