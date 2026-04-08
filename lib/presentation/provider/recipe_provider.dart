import 'package:flutter/material.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/repositories/recipe_repository.dart';

class RecipeProvider extends ChangeNotifier {
  final RecipeRepository repository;

  RecipeProvider({required this.repository});

  bool isLoading = false;
  String? error;

  List<Recipe> popularRecipes = [];
  List<Recipe> weeklyRecipes = [];
  String selectedCategory = 'All';

  Future<void> fetchHomeData() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      popularRecipes = await repository.getPopularRecipes();
      weeklyRecipes = await repository.getRecipesOfTheWeek();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> selectCategory(String category) async {
    selectedCategory = category;
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      popularRecipes = await repository.getRecipesByCategory(category);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<Recipe?> fetchRecipeDetails(int id) async {
    try {
      return await repository.getRecipeDetails(id);
    } catch (e) {
      return null;
    }
  }
}
