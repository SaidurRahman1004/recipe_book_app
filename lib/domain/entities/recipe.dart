class Ingredient {
  final int id;
  final String name;
  final double amount;
  final String unit;
  final String image;

  const Ingredient({
    required this.id,
    required this.name,
    required this.amount,
    required this.unit,
    required this.image,
  });
}

class Recipe {
  final int id;
  final String title;
  final String image;
  final double rating;
  final int readyInMinutes;
  final int calories;
  final String author;
  final String description;
  final String? sourceUrl;
  final List<Ingredient> ingredients;
  bool isSaved;
  bool isUntried;

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.rating,
    required this.readyInMinutes,
    required this.calories,
    required this.author,
    required this.description,
    this.sourceUrl,
    this.ingredients = const [],
    this.isSaved = false,
    this.isUntried = true,
  });
}
