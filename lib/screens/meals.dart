import 'package:flutter/material.dart';
import 'package:mis_lab2/widgets/meal_search_bar.dart';
import 'package:mis_lab2/widgets/meals_api_button.dart';
import '../models/meal_model.dart';
import '../services/api_service.dart';
import '../widgets/meal_card.dart';
import '../widgets/meal_grid.dart';
import 'favorites.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({super.key});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  final ApiService _api = ApiService();

  List<Meal> _meals = [];
  List<Meal> _filtered = [];

  bool _loading = true;
  bool _searchingApi = false;

  final TextEditingController _search = TextEditingController();

  late String categoryName;

  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      categoryName = ModalRoute.of(context)!.settings.arguments as String;
      _loadMeals();
      _initialized = true;
    }
  }


  void _loadMeals() async {
    final result = await _api.loadMealsByCategory(categoryName);

    setState(() {
      _meals = result;
      _filtered = result;
      _loading = false;
    });
  }


  void _filterMeals(String query) {
    final q = query.toLowerCase();

    final filtered = _meals.where((meal) {
      return meal.name.toLowerCase().contains(q);
    }).toList();

    setState(() {
      _filtered = filtered;
    });
  }

  Future<void> _searchMealsApi(String query) async {
    if (query.isEmpty) return;

    setState(() => _searchingApi = true);

    final result = await _api.searchMeals(query);

    setState(() {
      _searchingApi = false;
      _filtered = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        actions: [
          IconButton(
            icon: const Icon(Icons.star),
            onPressed: () async {
              await Navigator.pushNamed(context, "/favorites");
              setState(() {});
            },
          )
        ],

      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          MealsSearchBar(
              controller: _search,
              onChanged: _filterMeals,
              category: categoryName
          ),
          if (_filtered.isEmpty && _search.text.isNotEmpty)
            MealsApiButton(
              loading: _searchingApi,
              onPressed: () => _searchMealsApi(_search.text),
            ),
          Expanded(
            child:
            MealGrid(
              meals: _filtered,
              onRefresh: () => setState(() {}),)
          ),
        ],
      ),
    );
  }
}
