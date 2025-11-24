class Recipe{
  int id;
  String name;
  String img;
  String instructions;
  Map<String, String> ingredients;
  String ytlink;

  Recipe({
    required this.id,
    required this.name,
    required this.img,
    required this.instructions,
    required this.ingredients,
    required this.ytlink,
  });

  Recipe.fromJson(Map<String, dynamic> data)
      : id = int.tryParse(data["idMeal"].toString()) ?? 0,
        name = data["strMeal"],
        img = data["strMealThumb"],
        instructions = data["strInstructions"],
        ytlink = data["strYoutube"] ?? "",
        ingredients = _extractIngredients(data);

  static Map<String, String> _extractIngredients(Map<String, dynamic> data) {
    final Map<String, String> result = {};

    for (int i = 1; i <= 50; i++) {
      final ingred = data["strIngredient$i"];
      final measure = data["strMeasure$i"];

      if (ingred != null && ingred.toString().trim().isNotEmpty) {
        result[ingred] = measure ?? "";
      }
    }
    return result;
  }

}