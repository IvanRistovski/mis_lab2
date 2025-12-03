class Meal{
  int id;
  String name;
  String img;
  bool isFavourite;

  Meal({
    required this.id,
    required this.name,
    required this.img,
    this.isFavourite = false,
  });


  Meal.fromJson(Map<String,dynamic> data)
      : id = int.tryParse(data["idMeal"].toString()) ?? 0,
        name = data['strMeal'][0].toUpperCase() + data['strMeal'].substring(1),
        img = data['strMealThumb'],
        isFavourite = false;
}