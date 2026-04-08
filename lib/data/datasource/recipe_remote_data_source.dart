import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../models/recipe_model.dart';
import '../../domain/entities/recipe.dart';

abstract class RecipeRemoteDataSource {
  Future<List<RecipeModel>> fetchComplexRecipes({int count = 5, String? type});
  Future<RecipeModel> fetchRecipeDetails(int id);
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final http.Client client;

  RecipeRemoteDataSourceImpl({required this.client});

  @override
  Future<List<RecipeModel>> fetchComplexRecipes({
    int count = 5,
    String? type,
  }) async {
    String url =
        '${ApiConstants.baseUrl}/complexSearch?apiKey=${ApiConstants.apiKey}&number=$count&addRecipeInformation=true&addRecipeNutrition=true';
    if (type != null && type.isNotEmpty && type.toLowerCase() != 'all') {
      url += '&type=$type';
    }

    try {
      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List results = data['results'] ?? [];
        return results.map((e) => RecipeModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load recipes');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  @override
  Future<RecipeModel> fetchRecipeDetails(int id) async {
    final url =
        '${ApiConstants.baseUrl}/$id/information?apiKey=${ApiConstants.apiKey}&includeNutrition=true';
    try {
      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return RecipeModel.fromJson(data);
      } else {
        throw Exception('Failed to load recipe details');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
