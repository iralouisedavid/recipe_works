import 'package:flutter/foundation.dart';
import 'package:recipe_works/models/recipe.dart';
import 'package:recipe_works/services/recipe_api.dart';

class SearchViewModel extends ChangeNotifier {
  final RecipeApi _recipeApi = RecipeApi();
  List<Recipe?> _recipes = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Recipe?> get recipes => _recipes;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> searchRecipes(String query) async {
    try {
      _isLoading = true;
      _errorMessage = '';
      notifyListeners();

      final recipeDataList = await _recipeApi.searchRecipes(query);

      _recipes = recipeDataList.map((recipeData) {
        try {
          final recipe = Recipe.fromJson(recipeData);
          return recipe;
        } catch (e) {
          print('Error mapping recipe: $e');
          return null;
        }
      }).toList();

      _isLoading = false;
      _errorMessage = '';
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      _errorMessage = 'Failed to search recipes: $error';
      notifyListeners();
    }
  }
}
