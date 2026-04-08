import '../../domain/entities/recipe.dart';

class RecipeModel extends Recipe {
  RecipeModel({
    required super.id,
    required super.title,
    required super.image,
    required super.rating,
    required super.readyInMinutes,
    required super.calories,
    required super.author,
    required super.description,
    super.sourceUrl,
    super.ingredients,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    double tempRating = 4.5;
    if (json['spoonacularScore'] != null) {
      tempRating = (json['spoonacularScore'] / 20).toDouble();
      if (tempRating > 5.0) tempRating = 5.0;
    }

    int tempCalories = 300;
    if (json['nutrition'] != null && json['nutrition']['nutrients'] != null) {
      final nutrients = json['nutrition']['nutrients'] as List;
      final calNutrient = nutrients.firstWhere(
        (n) => n['name'] == 'Calories',
        orElse: () => null,
      );
      if (calNutrient != null) {
        tempCalories = calNutrient['amount'].toInt();
      }
    }

    List<Ingredient> ingredients = [];
    if (json['extendedIngredients'] != null) {
      ingredients = (json['extendedIngredients'] as List).map((e) {
        return Ingredient(
          id: e['id'] ?? 0,
          name: e['name'] ?? '',
          amount: (e['amount'] ?? 0).toDouble(),
          unit: e['unit'] ?? '',
          image: e['image'] != null
              ? 'https://spoonacular.com/cdn/ingredients_100x100/${e['image']}'
              : '',
        );
      }).toList();
    }

    return RecipeModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown Recipe',
      image: json['image'] ?? '',
      rating: tempRating,
      readyInMinutes: json['readyInMinutes'] ?? 30,
      calories: tempCalories,
      author: json['sourceName'] ?? json['creditsText'] ?? 'Unknown Author',
      description: json['summary'] ?? '',
      sourceUrl: json['sourceUrl'],
      ingredients: ingredients,
    );
  }
}
