import 'package:flutter/material.dart';
import '../../domain/entities/recipe.dart';

class SavedRecipeProvider extends ChangeNotifier {
  List<Recipe> _savedRecipes = [];

  List<Recipe> get savedRecipes => _savedRecipes;

  bool isSaved(int id) => _savedRecipes.any((r) => r.id == id);

  void toggleSave(Recipe recipe) {
    if (isSaved(recipe.id)) {
      _savedRecipes.removeWhere((r) => r.id == recipe.id);
      recipe.isSaved = false;
    } else {
      recipe.isSaved = true;
      _savedRecipes.add(recipe);
    }
    notifyListeners();
  }

  List<Recipe> get untriedRecipes =>
      _savedRecipes.where((r) => r.isUntried).toList();
  List<Recipe> get madeRecipes =>
      _savedRecipes.where((r) => !r.isUntried).toList();

  void toggleMadeIt(Recipe recipe) {
    final index = _savedRecipes.indexWhere((r) => r.id == recipe.id);
    if (index != -1) {
      _savedRecipes[index].isUntried = !_savedRecipes[index].isUntried;
      notifyListeners();
    }
  }
}
