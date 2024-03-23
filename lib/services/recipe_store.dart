import 'package:cookit/models/recipe_model.dart';
import 'package:cookit/services/database.dart';
import 'package:flutter/material.dart';

class RecipeStore extends ChangeNotifier {
  
  final List<Recipe> _recipes = [];

  get recipes => _recipes;

  Future<bool> addRecipe(Recipe recipe) async {
    bool isSuccess = await DatabaseService.addRecipeUsingModel(recipe);
    _recipes.add(recipe);
    notifyListeners();  //notifying listeners data has been changed to build again
    if(isSuccess) {
      return true;
    }else {
      return false;
    }
  }
}