import 'package:flutter/material.dart';
import '../models/meal_model.dart';

class MealCard extends StatefulWidget {
  final Meal meal;
  final VoidCallback onRefresh;

  const MealCard({super.key, required this.meal, required this.onRefresh});

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/recipe",
          arguments: widget.meal.id.toString(),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Image.network(
                    widget.meal.img,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.meal.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 6,
              top: 6,
              child: IconButton(
                iconSize: 35,
                icon: Icon(
                  widget.meal.isFavourite
                      ? Icons.star
                      : Icons.star_border,
                  color: widget.meal.isFavourite ? Colors.yellowAccent : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    widget.meal.isFavourite = !widget.meal.isFavourite;
                  });
                  widget.onRefresh();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
