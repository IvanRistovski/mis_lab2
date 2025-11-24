import 'package:flutter/material.dart';
import 'package:mis_lab2/screens/home.dart';
import 'package:mis_lab2/screens/meals.dart';
import 'package:mis_lab2/screens/recipe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const MyHomePage(title: 'Food App'),
        "/meals": (context) => const MealsScreen(),
        "/recipe": (context) => const RecipesScreen(),
      },
    );
  }
}


