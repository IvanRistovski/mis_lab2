class Meal{
  int id;
  String name;
  String img;

  Meal({
    required this.id,
    required this.name,
    required this.img,
  });


  Meal.fromJson(Map<String,dynamic> data)
      : id = int.tryParse(data["idMeal"].toString()) ?? 0,
        name = data['strMeal'][0].toUpperCase() + data['strMeal'].substring(1),
        img = data['strMealThumb'];
}