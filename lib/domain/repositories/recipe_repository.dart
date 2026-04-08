import '../entities/recipe.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> getPopularRecipes();
  Future<List<Recipe>> getRecipesOfTheWeek();
  Future<List<Recipe>> getRecipesByCategory(String category);
  Future<Recipe> getRecipeDetails(int id);
  Future<String?> getRecipeVideo(String query);
}
