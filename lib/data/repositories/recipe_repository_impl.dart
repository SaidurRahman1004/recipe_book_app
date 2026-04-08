import '../../domain/entities/recipe.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../datasource/recipe_remote_data_source.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource remoteDataSource;

  RecipeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Recipe>> getPopularRecipes() async {
    return await remoteDataSource.fetchComplexRecipes(count: 5);
  }

  @override
  Future<List<Recipe>> getRecipesOfTheWeek() async {
    return await remoteDataSource.fetchComplexRecipes(
      count: 5,
      type: 'main course',
    );
  }

  @override
  Future<List<Recipe>> getRecipesByCategory(String category) async {
    return await remoteDataSource.fetchComplexRecipes(
      count: 8,
      type: category.toLowerCase(),
    );
  }

  @override
  Future<Recipe> getRecipeDetails(int id) async {
    return await remoteDataSource.fetchRecipeDetails(id);
  }

  @override
  Future<String?> getRecipeVideo(String query) async {
    return await remoteDataSource.fetchRecipeVideo(query);
  }
}
