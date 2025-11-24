import 'package:flutter/material.dart';
import 'package:mis_lab2/widgets/category_list.dart';
import 'package:mis_lab2/widgets/category_search_bar.dart';
import 'package:mis_lab2/widgets/random_button.dart';
import '../services/api_service.dart';
import '../models/category_model.dart';
import '../widgets/category_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Category> _categories = [];
  List<Category> _filtered = [];

  bool _isLoading = true;

  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() async {
    final result = await _apiService.loadCategories();

    setState(() {
      _categories = result;
      _filtered = result;
      _isLoading = false;
    });
  }

  void _filter(String query) {
    final q = query.toLowerCase();

    final filtered = _categories.where((c) {
      return c.name.toLowerCase().contains(q);
    }).toList();

    setState(() {
      _filtered = filtered;
    });
  }

  void _openRandomRecipe() async {
    final recipe = await _apiService.loadRandomRecipe();
    if (recipe == null) return;

    if (!mounted) return;

    Navigator.pushNamed(
      context,
      "/recipe",
      arguments: recipe.id.toString(),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meal Categories"),
        actions: [
          RandomButton(onPressed: _openRandomRecipe)
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: CategorySearchBar(controller: _searchController, onChanged: _filter)
          ),
          Expanded(
            child: CategoryList(categories: _filtered)
          ),
        ],
      ),
    );
  }
}
